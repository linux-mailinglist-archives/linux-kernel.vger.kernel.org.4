Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E6B691946
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjBJHgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjBJHgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:36:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29983765EB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676014555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYEWX7jqjucAfdMA3biMOX8rqv+ik86o/ADDxCienSs=;
        b=aZWtDaA7Yi1qXoSr60NEQJ9Pk40pqg0s0C5uLJ3yCzdUUshek4OPp036NtBP7Kb1Gy15gQ
        Yw/GE+Oek/YKJYQMpIBYhTs2ImDHVeNmCKtB+DH7sUuFB9xhyen8FmiJ2o04Z9YePdmyZI
        7e9yXZhiT1s8hAFM6oRfCtSyDHut1ck=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-QauAyOP0N0CmFK3d2ZcJZw-1; Fri, 10 Feb 2023 02:35:54 -0500
X-MC-Unique: QauAyOP0N0CmFK3d2ZcJZw-1
Received: by mail-ej1-f71.google.com with SMTP id qn8-20020a170907210800b0088eda544bd6so3125591ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 23:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYEWX7jqjucAfdMA3biMOX8rqv+ik86o/ADDxCienSs=;
        b=1dH0z8uEjJfZS4A06xN3J7DDEEqEOKzE2kumDDgjKwKFCoGu4ktOFA5mgAbuDkhyT8
         pkTLjHcPckBiLnHp32t6uVBz4kFrJ8N7DwtJrbdDO3g2l2mY+h7cvbdoh/q7B8GfylR7
         T9e3MdzBj8hI8uR9auHA7RZgJmlwk39X3Yh2vTiz25EiyEPlfm56bYNyGXKs56wgRsfg
         LFFe7D490jjCXlx/fvbxJFcRQSCcGeG/TMvyTyV9xs5g9f2FluEKkUoyIsFQI/uwgI6h
         NuWx2GCNSw98PAgRID2IZA15Z+KSPRf4oymyBVUerCls+pkz+IdMrU+GqanLLuvEuzLt
         yVyg==
X-Gm-Message-State: AO0yUKX1XFtFr4sJ2KXZ4MhKZ+rOB63W3nEojfQeyViLuEryzdte5Jch
        jwxSx6fMEHQx16w1Dl1OXohI0IBihLu21BOJXldcdVSYpUb7jtLU1H6yExN515+eto97d9l7aPJ
        FoqOzrExcMmFOidHQVqWTXFd7
X-Received: by 2002:a50:d0c2:0:b0:4ab:255e:bd6e with SMTP id g2-20020a50d0c2000000b004ab255ebd6emr3243754edf.27.1676014552986;
        Thu, 09 Feb 2023 23:35:52 -0800 (PST)
X-Google-Smtp-Source: AK7set/ouhqSt0CZoGDOL+o9lywStvnOVeGxmXezs5trlWDgApfJQqfQuT4q+7FFgE349aab9bsPZQ==
X-Received: by 2002:a50:d0c2:0:b0:4ab:255e:bd6e with SMTP id g2-20020a50d0c2000000b004ab255ebd6emr3243745edf.27.1676014552750;
        Thu, 09 Feb 2023 23:35:52 -0800 (PST)
Received: from [10.39.192.156] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id r12-20020a50c00c000000b0049dd7eec977sm1820128edb.41.2023.02.09.23.35.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Feb 2023 23:35:51 -0800 (PST)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     pshelar@ovn.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, xiangxia.m.yue@gmail.com,
        simon.horman@corigine.com, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: openvswitch: fix possible memory leak in
 ovs_meter_cmd_set()
Date:   Fri, 10 Feb 2023 08:35:50 +0100
X-Mailer: MailMate (1.14r5942)
Message-ID: <6582F9D7-D74B-4A4A-A498-1B3002B9840E@redhat.com>
In-Reply-To: <20230210020551.6682-1-hbh25y@gmail.com>
References: <20230210020551.6682-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10 Feb 2023, at 3:05, Hangyu Hua wrote:

> old_meter needs to be free after it is detached regardless of whether
> the new meter is successfully attached.
>
> Fixes: c7c4c44c9a95 ("net: openvswitch: expand the meters supported num=
ber")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Thanks for doing a v3. The change looks good to me!

Acked-by: Eelco Chaudron <echaudro@redhat.com>

> ---
>
> v2: use goto label and free old_meter outside of ovs lock.
>
> v3: add the label and keep the lock in place.
>
>  net/openvswitch/meter.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
> index 6e38f68f88c2..f2698d2316df 100644
> --- a/net/openvswitch/meter.c
> +++ b/net/openvswitch/meter.c
> @@ -449,7 +449,7 @@ static int ovs_meter_cmd_set(struct sk_buff *skb, s=
truct genl_info *info)
>
>  	err =3D attach_meter(meter_tbl, meter);
>  	if (err)
> -		goto exit_unlock;
> +		goto exit_free_old_meter;
>  	ovs_unlock();
>
> @@ -472,6 +472,8 @@ static int ovs_meter_cmd_set(struct sk_buff *skb, s=
truct genl_info *info)
>  	genlmsg_end(reply, ovs_reply_header);
>  	return genlmsg_reply(reply, info);
>
> +exit_free_old_meter:
> +	ovs_meter_free(old_meter);
>  exit_unlock:
>  	ovs_unlock();
>  	nlmsg_free(reply);
> -- =

> 2.34.1

