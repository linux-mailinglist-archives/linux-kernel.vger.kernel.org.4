Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B116472E2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbjFMM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbjFMM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DDD10CE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686659174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdc7U94xkVs29WOVZE2o7NQmpfO54OWwBKACRIySOxQ=;
        b=V63tEdjXP0ZdVG0+y48WCXYK/xdbMrZFAvPP2bPcjERQT4t6itZBf2LIzwjchP0pdsu8fW
        g0BZuSAz8q+ZwCZnSptr5cZh7JML0i52239ywE0fMg0+F5+EJroxczYfYAvWrbJeLEH87V
        2Hfii7MI84U7Zj1Gq/YEKl2qgLpw6yU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-vgDbyjj7PpileyrjZhvWZg-1; Tue, 13 Jun 2023 08:26:11 -0400
X-MC-Unique: vgDbyjj7PpileyrjZhvWZg-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-558cbf62c87so3425250eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659170; x=1689251170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdc7U94xkVs29WOVZE2o7NQmpfO54OWwBKACRIySOxQ=;
        b=YxCPm4U1QUY7Xh/WudasRTcldX8Bo6edb+9Y7wByxfSh2tkzO9G03CP0usFRA5ZAUa
         UOU2zeCBWs80stf5bq+SQ88s58PgnFkSHm0npcP1YNLk9T7P1OK1VA30CEchPzKxQXqj
         3SKcckphlhSlDeWpcSHJvYPitwn2KGH6W3RFBxYoNE0cLtc5mvuhVh9MSWvFdGavx/RL
         O0bp2MKi/J3rqUutYQ2zz1DPpAeGC6ZPYJlAdmiAEXDVfwY1FknjOHkUyvPW1I418wiL
         gSTzhs9mAvzPWBcdxiKoAAF/lJuGt208/AVX51zt5YCq9goyoYotkZTpNyNEraWZd4mK
         fJyA==
X-Gm-Message-State: AC+VfDyiYcMnJnP7nbbaEB8qLa4urnN1U3j/ZUE9tN0N8ixxYp6h8QaW
        lI+IeXMxG8S3FwEf/uF2/ILNVAtl7nguPAP0G1ZsikJF9f7aKr9CGwadClUD8Ax/SqRJAz25jE+
        KoWoj/+54e9AxbSr61M1eDtg7cvq420bYx9Gdw3C6
X-Received: by 2002:a05:6808:aa6:b0:39c:7a71:945 with SMTP id r6-20020a0568080aa600b0039c7a710945mr6665209oij.56.1686659170673;
        Tue, 13 Jun 2023 05:26:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78NH/EDUObpqeiuWTv/ei0rcNTq2G3JcAYYkdP6lUVZNrwES4dFqTfrj6xUXLkqd2QPOhn4hynFlH1BTjrtsI=
X-Received: by 2002:a05:6808:aa6:b0:39c:7a71:945 with SMTP id
 r6-20020a0568080aa600b0039c7a710945mr6665199oij.56.1686659170481; Tue, 13 Jun
 2023 05:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-3-yukuai1@huaweicloud.com> <b780ccfd-66b1-fdd1-b33e-aa680fbd86f1@redhat.com>
 <1aaf9150-bbd3-87a8-8d54-8b5d63ab5ed3@huaweicloud.com>
In-Reply-To: <1aaf9150-bbd3-87a8-8d54-8b5d63ab5ed3@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 13 Jun 2023 20:25:59 +0800
Message-ID: <CALTww2-ta1NUJxcT3Dq5KP7iunnVx24X7RKj1OKYTYwEPeDNrg@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH -next v2 2/6] md: refactor action_store() for
 'idle' and 'frozen'
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 8:00=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/13 16:02, Xiao Ni =E5=86=99=E9=81=93:
> >
> > =E5=9C=A8 2023/5/29 =E4=B8=8B=E5=8D=889:20, Yu Kuai =E5=86=99=E9=81=93:
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Prepare to handle 'idle' and 'frozen' differently to fix a deadlock,
> >> there
> >> are no functional changes except that MD_RECOVERY_RUNNING is checked
> >> again after 'reconfig_mutex' is held.
> >
> >
> > Can you explain more about why it needs to check MD_RECOVERY_RUNNING
> > again here?
>
> As I explain in the following comment:

Hi

Who can clear the flag before the lock is held?

Regards
Xiao
> >> +    /*
> >> +     * Check again in case MD_RECOVERY_RUNNING is cleared before lock=
 is
> >> +     * held.
> >> +     */
> >> +    if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> >> +        mddev_unlock(mddev);
> >> +        return;
> >> +    }
>
> Thanks,
> Kuai
>

