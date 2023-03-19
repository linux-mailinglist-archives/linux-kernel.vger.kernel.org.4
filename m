Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E356C05B5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCSVmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCSVmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:42:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA771CF48
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679262168; x=1710798168;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ng7kfezo8hw0LOeKsPNHr3k1ksn89DrIOwEfRACFEbw=;
  b=A2ty4XF5WU+XOtl6gOdaXfpIglmtmfyJ0KTiumQVqD01L0S6axuG8Vya
   JBI/y69lf3Ni0v3BIFOdBJ7lrtcogwK1Ol15DI2uocjKXh9bV7bd4dM2t
   QvHhIK5Q5rwBa/+eB9GUmzBthOhIzBt0Kqe5ry5YzjrbEZ/vgUxgR6Xnw
   pm9EUbIr5iKRh1WB7FsFLgtJd1EmK0vopQAZC/JlYRVPWy1eZO7UoBlWl
   Gp2XRUDFMgr1Fk/v/NKtWgN+4xlJoDz9ljTt5vnDjVfVIBdXwSsxT+U7y
   H7YBKYarZtYTt/mkQnSHIYcdXdWbW4m3/brBQNxBElQstc/6TBKAukf4+
   w==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="224272763"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 05:42:43 +0800
IronPort-SDR: Q3iJF1edugJvYKh66IwJI9tdq73lubjv99XiGhtSHLG/7Auw7ujq/7H7YGV3hqjAI7sKKV1biu
 x1DB4ZU22WBGcrMByU3b1bsbZwzA18MfzyTD95Ro8SCcdM+N9jqS95yqH8Pdgn/n6xqfcv8Gh0
 llAKPvtc5cBkvGCx7UuhVKMfD1QYiZai9lKnd1oLnUpud7yd0F2Jh0rhQtnDSgyYQ0UJv5lfn5
 wmoLKtGx2ZTtJw/2z9Lz+pMi/8qX9p55W+xe5JJfBOmJ/i4nxkjHc20oPR+Lyh2nuQ4V9zN6cs
 OrM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 13:59:01 -0700
IronPort-SDR: xG06wtZR+Gr26GiHE+Tgw6InokIL1Z8XQwtGSnEadAnYt8zHnknWx9ofKtHtK9Jj2baA8FHjYW
 YTxywvOY5HlXuf50mgHz6vikLp/iWml3TO+3iTkKFviA40F+FCoRegISxLXBZVjCVVoCVzn3j4
 fNfnln7kVBj8/1PWCglC07Z3vr34w4qfM62yRq71/oLXKVbdJ44rblDTf5BFxEWiCwGiZD8OtX
 h6wUl+lCQ+l4/AqlsuuiyT2nuPJUtc0JzxOqcp/n2L5KONhGObkssOvZRa6Ak6HHLT69x6Ri3M
 3RA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 14:42:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pfrv41sdcz1RtVq
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:42:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679262159; x=1681854160; bh=Ng7kfezo8hw0LOeKsPNHr3k1ksn89DrIOwE
        fRACFEbw=; b=r6QvF7zuIXNpXW1h0bPUFVDrbFYPWJdYpnvcZY3PpIIiTte3pNM
        W1yzPtCNolIWrBUwh1Kt7CHq61FKn4X7ceZtPOTH/muaSQDhVSxGauL1eMquK506
        h9b7LRsfic9X34KmvFfUq9t5WsC+PR2Nh9VoY7iXcTkYWf1TLhVgDYkZWq51J/5a
        SBXzCMRtyipdj0uTnwsE6SKNQZE499kXrNCqLf4OH7XK06sqHZcvj1xjjRv+Ngs/
        4ss+HZYD33FhE0AouSwRKE5QKE2eT+iwSd+RgjQDLv73jdp8mTIXn3jFCuyvouJC
        RKGXM2msoWQwWPtrzur37eDmQ52uD85QwGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 11V_MeKC6DgZ for <linux-kernel@vger.kernel.org>;
        Sun, 19 Mar 2023 14:42:39 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pfrv21Jkyz1RtVm;
        Sun, 19 Mar 2023 14:42:37 -0700 (PDT)
Message-ID: <e98525c5-9420-63f8-a1f3-009601d02f2c@opensource.wdc.com>
Date:   Mon, 20 Mar 2023 06:42:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2, RESEND 04/10] zonefs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230319092641.41917-1-frank.li@vivo.com>
 <20230319092641.41917-4-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230319092641.41917-4-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/23 18:26, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/zonefs/sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> index 8ccb65c2b419..5e117188fbb5 100644
> --- a/fs/zonefs/sysfs.c
> +++ b/fs/zonefs/sysfs.c
> @@ -113,8 +113,7 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>  	if (!sbi || !sbi->s_sysfs_registered)
>  		return;
>  
> -	kobject_del(&sbi->s_kobj);
> -	kobject_put(&sbi->s_kobj);
> +	kobject_del_and_put(&sbi->s_kobj);
>  	wait_for_completion(&sbi->s_kobj_unregister);

There is no function kobject_del_and_put() in rc3. I guess it is introduced by
this series but since you did not send everything, it is impossible to review.
Please always send the full patch series so that reviewers have all the context
that is needed to review/ack.

>  }
>  

-- 
Damien Le Moal
Western Digital Research

