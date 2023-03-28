Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE08F6CC176
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC1Nxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjC1Nxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F68A5C5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680011563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lj+lqmXXS0BSikuA1TdKYzG9abofXGYmvsNuCdhCLz8=;
        b=FYIKUnu4O4fWwrwalTCOfjjHkXf12Ymk/4lVH5i13RoeyczFYSV6jc/Leig1EFYgTZJO3n
        AFwHzvCaOV3MnllS+uhFyIR7cWWf6jrE1Lm8R7ughNuf2BJxJKLahDGyWGx8BlubxkfcPZ
        JLDj4nR/MsvjHpY1oeAYuT+4WwQaQ6A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-oQ0q1b5hMJ2oktgkK2vjqw-1; Tue, 28 Mar 2023 09:52:42 -0400
X-MC-Unique: oQ0q1b5hMJ2oktgkK2vjqw-1
Received: by mail-qt1-f197.google.com with SMTP id v7-20020a05622a188700b003e0e27bbc2eso8185636qtc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lj+lqmXXS0BSikuA1TdKYzG9abofXGYmvsNuCdhCLz8=;
        b=hEDDmWVZvyCBL6XTNi8oK+mzabN/hVhWESBuiaIeGCBucxRdRZXZMc/FW3AJMDaItF
         kVC404WN+fYGMZhcp0U61cBJLBXBYNyh7+QQlA0nZU5r9k6DrsCYOvj40dDHWjgXtTYz
         313LkwjN5HaiKRQ2z6ngT5tsA2Ls9cNltF46miq0Y2qpFnOAkNPBBHZSe6BcMxR8uae+
         7DoKdIyDK3K5AI6sDPKc9n9zqgGFHq+dg7cDD9dHqDf4C7iEWRHms5S4L6o67HunrD7N
         ECetusrXo9PcBkQ8XVJFF6oMae8d4N3JZS3qYuL29EKrgnqq0rSx1HHB4/CWFZSbtGkm
         DvUw==
X-Gm-Message-State: AO0yUKWp5sNdvqnJ3IopKKziWx3RfPBmEcEiGOYvnZVCaRMCDg8jrwZx
        Qg11wpMRvU+aZjRkBXSDAIu8EoeLqhlxudanJ/yjBp7NX38FGhasn3ieUzihvofyfvlyNUyJfZh
        YgIxeTl6hCFkzUWYYzosuz6Xw
X-Received: by 2002:ac8:5c49:0:b0:3e1:b2b4:f766 with SMTP id j9-20020ac85c49000000b003e1b2b4f766mr26805725qtj.5.1680011561953;
        Tue, 28 Mar 2023 06:52:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set+Nsnehld0v77wMMLYEKM1+leVknIUJ69BwExMVTazmwQLBmfGnLpDVN40nlnWtQr6AxhbgBA==
X-Received: by 2002:ac8:5c49:0:b0:3e1:b2b4:f766 with SMTP id j9-20020ac85c49000000b003e1b2b4f766mr26805706qtj.5.1680011561719;
        Tue, 28 Mar 2023 06:52:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-148.dyn.eolo.it. [146.241.232.148])
        by smtp.gmail.com with ESMTPSA id s20-20020a374514000000b00746b2ca65edsm7102786qka.75.2023.03.28.06.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:52:41 -0700 (PDT)
Message-ID: <da45f73bcc2642260ef7718a6650dc535cc05c86.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] xen/netback: fix issue introduced recently
From:   Paolo Abeni <pabeni@redhat.com>
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        xen-devel@lists.xenproject.org, stable@vger.kernel.org
Date:   Tue, 28 Mar 2023 15:52:38 +0200
In-Reply-To: <20230328131047.2440-1-jgross@suse.com>
References: <20230328131047.2440-1-jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2023-03-28 at 15:10 +0200, Juergen Gross wrote:
> The fix for XSA-423 introduced a bug which resulted in loss of network
> connection in some configurations.
>=20
> The first patch is fixing the issue, while the second one is removing
> a test which isn't needed. The third patch is making error messages
> more uniform.
>=20
> Changes in V2:
> - add patch 3
> - comment addressed (patch 1)

I misread the thread on v2 as the build_bug_on() was not needed and
applied such revision.=C2=A0

Please rebase any further change on top of current net.

Thanks,

Paolo

