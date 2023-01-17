Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECBA66DEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjAQNbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjAQNaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:30:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCC534C27
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673962199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg5kf88GjqS04Xb1aZZOdM/bpUlV1+UcrEUkKV/unbY=;
        b=Pt2eFDCyAn/W+BjvMk4TXUHnSy/aZy97U4tW/D9vxwrEVq6Bzq+BFGaouxKRf9mWVzqj6d
        eVEWQOacMxs0iwzAAE8tEHDu43f7anRNXBI15nxORT83z7r1sqpeCDmQKKlE7ZIjJyEk25
        BW7sK9qo1jhY4Lcr7Uvpk/kCs3bdKGw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-cLNA9ytjN2iFebV5RpfCFQ-1; Tue, 17 Jan 2023 08:29:58 -0500
X-MC-Unique: cLNA9ytjN2iFebV5RpfCFQ-1
Received: by mail-ej1-f71.google.com with SMTP id wz4-20020a170906fe4400b0084c7e7eb6d0so21708567ejb.19
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fg5kf88GjqS04Xb1aZZOdM/bpUlV1+UcrEUkKV/unbY=;
        b=FQqgKfUODjKhm20nR10ahQUhjH/9sl2UcbHfnB7mYnVroTDuD3upd8YAPaYahXB0vw
         pl6a9wmX+2oAvs+lh1GBECaOOK6JG+TkNjoQ8SykrtS4ffFltt/iP3vQulVs3LjEAWCb
         n9St6t022R3RZIfFmklVueN0oQkjC0grPmrOZUkMOOSJkq7ojJMNjPZ0ul6gzCZG4kCm
         22/vLoQhs+XT+9y0GWWMN+gpJV8YPap6TUwKx3vhADuH6U9vUOmB8tvlq37rB+TUrHJs
         RIkYnzITHHJCuus+S8ZFaogM32NvO936v5cXj6YhCu2L9clcezmrCyXl6eJ4SZ/nOKWx
         aE/A==
X-Gm-Message-State: AFqh2kqZvbgMtM0ZmAeU3hJvGZXHcTVVwOm0uPgx+KttvqwdY7CGA3h1
        yj2+W5GY4/IKl3r6lzEkjPFtFwBCOTFi+7osE3Nswe9WjGDxVvfHIQKmnvj0m8tNP0tObU3fGQN
        BGRkYBoZKTPB5x1oKCb6Fmhxe
X-Received: by 2002:a17:906:8c3:b0:84d:2078:1fd6 with SMTP id o3-20020a17090608c300b0084d20781fd6mr15804518eje.34.1673962197358;
        Tue, 17 Jan 2023 05:29:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs4ppsVj8TweMfZFp4njVAMcfarVsL1T9Z+OFXOiy9wE7bJvkJqpL+ZIHB9IWVvxpDcrsmI/A==
X-Received: by 2002:a17:906:8c3:b0:84d:2078:1fd6 with SMTP id o3-20020a17090608c300b0084d20781fd6mr15804498eje.34.1673962197134;
        Tue, 17 Jan 2023 05:29:57 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906314200b007c08439161dsm13100156eje.50.2023.01.17.05.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:29:56 -0800 (PST)
Message-ID: <00f8557d8164cc695a2d2684fd12a724695ffac1.camel@redhat.com>
Subject: Re: [PATCH v2 4/6] composefs: Add filesystem implementation
From:   Alexander Larsson <alexl@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Date:   Tue, 17 Jan 2023 14:29:55 +0100
In-Reply-To: <Y8XKtqfmtulLcuWi@ZenIV>
References: <cover.1673623253.git.alexl@redhat.com>
         <ee96ab52b9d2ab58e7b793e34ce5dc956686ada9.1673623253.git.alexl@redhat.com>
         <Y8XKtqfmtulLcuWi@ZenIV>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-16 at 22:07 +0000, Al Viro wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Several random observatio=
ns:

Thanks, I'll integrate this in the next version.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a scrappy ninja firefighter possessed of the uncanny powers of an=20
insect. She's a blind punk former first lady with an evil twin sister.=20
They fight crime!=20

