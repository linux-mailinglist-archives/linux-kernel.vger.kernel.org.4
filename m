Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E046FF205
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbjEKNB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbjEKNBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4696193
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683810029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YNgJu9g4hsRAs0h9Bi/9rkG5y7jrDdpJUfTR0KD1Tg=;
        b=MFuv4tzHyMoUJDKq2BoIp2XmufbDzJCZRNRnO1CACAd/m9Vw0Qtzy4+DPm6KKnrHLc0RFb
        zuqikoyuLRwd4xgXbQiqc3UIkI3IqDzr23QPjbKxas/WJr4Mf5wtKDWqcmwT5zatebag2U
        Pl/cTwMGeU9BAi+aRKHo2zhC3Og417o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-u4i_vyS9P3yW4jl_E9czuw-1; Thu, 11 May 2023 09:00:27 -0400
X-MC-Unique: u4i_vyS9P3yW4jl_E9czuw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-306286b3573so5247982f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683810027; x=1686402027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YNgJu9g4hsRAs0h9Bi/9rkG5y7jrDdpJUfTR0KD1Tg=;
        b=TXBiIycegUq6KK063peDdVYzKnus9+558NtUzM3h7B02EAmcsuH9thRHxQrhxq3+io
         qjwovuBdJfnnGaTznmBeY+kHS1phQuGVp99zRoYtIBV0f/6V+HC/nCHc35uymaLZ77vR
         Wek4eOST8jzaiCfWur6qzYKyuSWuy1ENObnRNDG5HVPcwDA30DnzaQeci/Iacp5G1dhE
         jNQOGezk8hPwaG1lDwq/5xumZOu0ssP3jilNo5wGp6Lm1ChG8Lj5KcVr8DZFBketE4uo
         Uw8wmFTVHFMUVltQ2vQMbvZ80WLamolEPmanWJ7Q41gXd5XOyisbQ3vyiphcyDuzRgW0
         PMgg==
X-Gm-Message-State: AC+VfDxXRLYlU/kwkpQcdFJl2MVLEn0iOO9ulVPf/q+jthv8ufqNR67K
        IOpmnCVpuo9MkPgpWWH9pNckXdBEAUITb5XgOf1yPORglRmBnObcnc8mlt9dqu6zsz8jzGssgFj
        0eHJKC+/gxeL1HeyHH/JegwTW
X-Received: by 2002:a5d:55cf:0:b0:304:b967:956f with SMTP id i15-20020a5d55cf000000b00304b967956fmr16336614wrw.8.1683810026738;
        Thu, 11 May 2023 06:00:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6maX1bAPZW0k8hxurkuPzMZqG473m27W7e8iBYUPNc8cfDsYenYLW5jeTNv5v8llwVfwyINA==
X-Received: by 2002:a5d:55cf:0:b0:304:b967:956f with SMTP id i15-20020a5d55cf000000b00304b967956fmr16336585wrw.8.1683810026412;
        Thu, 11 May 2023 06:00:26 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.69.175])
        by smtp.gmail.com with ESMTPSA id w14-20020a5d680e000000b003079693eff2sm12447627wru.41.2023.05.11.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:00:25 -0700 (PDT)
Date:   Thu, 11 May 2023 15:00:20 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Zhuang Shengen <zhuangshengen@huawei.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com, longpeng2@huawei.com,
        jianjay.zhou@huawei.com
Subject: Re: [PATCH net v2] vsock: avoid to close connected socket after the
 timeout
Message-ID: <atd47kt3wyhw2mhrzob4fxzlvmw37xviehn7agao3srni2jmts@gxgzvqrb7mc7>
References: <20230511113430.646292-1-zhuangshengen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511113430.646292-1-zhuangshengen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 07:34:30PM +0800, Zhuang Shengen wrote:
>When client and server establish a connection through vsock,
>the client send a request to the server to initiate the connection,
>then start a timer to wait for the server's response. When the server's
>RESPONSE message arrives, the timer also times out and exits. The
>server's RESPONSE message is processed first, and the connection is
>established. However, the client's timer also times out, the original
>processing logic of the client is to directly set the state of this vsock
>to CLOSE and return ETIMEDOUT. It will not notify the server when the port
>is released, causing the server port remain.
>when client's vsock_connect timeout，it should check sk state is
>ESTABLISHED or not. if sk state is ESTABLISHED, it means the connection
>is established, the client should not set the sk state to CLOSE
>
>Note: I encountered this issue on kernel-4.18, which can be fixed by
>this patch. Then I checked the latest code in the community
>and found similar issue.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Zhuang Shengen <zhuangshengen@huawei.com>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I noticed that the net maintainers are not in cc, if this patch isn't
queued in the next days, please resend it by cc'ing all the
maintainers [1]:

$ ./scripts/get_maintainer.pl \
   20230510_zhuangshengen_vsock_bugfix_port_residue_in_server.mbx
Stefano Garzarella <sgarzare@redhat.com> (maintainer:VM SOCKETS (AF_VSOCK))
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
virtualization@lists.linux-foundation.org (open list:VM SOCKETS (AF_VSOCK))
netdev@vger.kernel.org (open list:VM SOCKETS (AF_VSOCK))
linux-kernel@vger.kernel.org (open list)

Thanks,
Stefano

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#select-the-recipients-for-your-patch

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 413407bb646c..efb8a0937a13 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1462,7 +1462,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			vsock_transport_cancel_pkt(vsk);
> 			vsock_remove_connected(vsk);
> 			goto out_wait;
>-		} else if (timeout == 0) {
>+		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
> 			err = -ETIMEDOUT;
> 			sk->sk_state = TCP_CLOSE;
> 			sock->state = SS_UNCONNECTED;
>-- 
>2.27.0
>

