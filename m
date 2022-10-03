Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFC95F321F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJCOqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJCOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:46:07 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785A2CC99;
        Mon,  3 Oct 2022 07:46:02 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 4F8B04014D;
        Mon,  3 Oct 2022 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1664808359; x=1666622760; bh=f28REBdwbZdrdcPTca7rbkrfq1ht6ZdCGpO
        41DAmRLg=; b=WqGHMYAcBuNTCREijAVP30718Csy1K1QNSUk9P8n1tXHIHqDxvY
        w66U9G8G+RbOhbmplOXnRdVHGgBEqJuu89RkSPYIV9GOrJakE94LPx38hdCh8nsN
        PWQLvtuhZenm3E557Ig9bqGkPpLp4RXiHbhRWFz/XMKI8DCbe0qsoFkM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IgLBIl9YdqaE; Mon,  3 Oct 2022 17:45:59 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 714CE400F6;
        Mon,  3 Oct 2022 17:45:55 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 3 Oct 2022 17:45:55 +0300
Received: from yadro.com (10.199.18.20) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Mon, 3 Oct 2022
 17:45:55 +0300
Date:   Mon, 3 Oct 2022 17:46:02 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Duoming Zhou <duoming@zju.edu.cn>
CC:     <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <kuba@kernel.org>, <davem@davemloft.net>, <andrii@kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>
Subject: Re: [PATCH] scsi: target: iscsi: cxgbit: fix sleep-in-atomic-context
 bug in cxgbit_abort_conn
Message-ID: <20221003144602.GA10901@yadro.com>
References: <20221002014047.23066-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221002014047.23066-1-duoming@zju.edu.cn>
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 09:40:47AM +0800, Duoming Zhou wrote:
> 
> The function iscsit_handle_time2retain_timeout() is a timer handler that
> runs in an atomic context, but it calls "alloc_skb(0, GFP_KERNEL | ...)"
> that may sleep. As a result, the sleep-in-atomic-context bug will happen.
> The process is shown below:
> 
> iscsit_handle_time2retain_timeout()
>  iscsit_close_session()
>   iscsit_free_connection_recovery_entries()
>    iscsit_free_cmd()
>     __iscsit_free_cmd()
>      cxgbit_unmap_cmd()
>       cxgbit_abort_conn()
>        alloc_skb(0, GFP_KERNEL | ...) //may sleep
> 
> This patch changes the gfp_t parameter of alloc_skb() from GFP_KERNEL to
> GFP_ATOMIC in order to mitigate the bug.
> 
> Fixes: 1ae01724ae92 ("cxgbit: Abort the TCP connection in case of data out timeout")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  drivers/target/iscsi/cxgbit/cxgbit_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> index 3336d2b78bf..eb3da6d2c62 100644
> --- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> +++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> @@ -697,7 +697,7 @@ __cxgbit_abort_conn(struct cxgbit_sock *csk, struct sk_buff *skb)
> 
>  void cxgbit_abort_conn(struct cxgbit_sock *csk)
>  {
> -       struct sk_buff *skb = alloc_skb(0, GFP_KERNEL | __GFP_NOFAIL);
> +       struct sk_buff *skb = alloc_skb(0, GFP_ATOMIC | __GFP_NOFAIL);
> 
>         cxgbit_get_csk(csk);
>         cxgbit_init_wr_wait(&csk->com.wr_wait);
> --
> 2.17.1
>

The last line in cxgbit_abort_conn is cxgbit_wait_for_reply() which
also should not be called in interrupt context.

Anyway this issue is not due to cxgbit, it is common for iSCSI itself:
iscsit_close_session()
  iscsit_free_connection_recovery_entries()
    iscsit_free_cmd()
      transport_generic_free_cmd()
        target_wait_free_cmd()
          wait_for_completion_timeout()

IMHO, there is no reason to call iscsit_close_session in an atomic context.
I have two patches relaited Time2Retain timer. I will share them today.

BR,
 Dmitry 
