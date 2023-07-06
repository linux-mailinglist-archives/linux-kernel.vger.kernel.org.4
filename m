Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D60274A5E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGFVbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGFVbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D09DD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688679048;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7jc5Xt5OwHj0jB9aQC+Uq3PbScwoHTvSP8Bz1i/QuU=;
        b=UKjBqyEfqNaILtNw1IvjtMnn+F3LbHq3Vw1ABM+cE/oCqiwH3BzFDxDZpfXQUuh48CbbAr
        LUYRLgTh4UDqcCWb7Svz8GuHraLERoVi6AvV2gGBGgK9gcHmf5p6W9mtAZ9UJ5kcbmDFZO
        +ADTkMOh077tRCfw2g87EMzdh01cjJ0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146--_gepZ5EPkOtWmARcootgQ-1; Thu, 06 Jul 2023 17:30:47 -0400
X-MC-Unique: -_gepZ5EPkOtWmARcootgQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765a44ce88aso88804085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688679046; x=1691271046;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7jc5Xt5OwHj0jB9aQC+Uq3PbScwoHTvSP8Bz1i/QuU=;
        b=VLlySSfD9uJ0SIEa4KCan6+GyeTYa/b55PCV9eNnJerFA+LncxELUshEsZh84O5BB/
         nwobo9HfIXu/QpTXzgQqiS/JxQWnpNNcdI9KJrYeIlRaWREfDRagri8ZPCroZ7nrlE81
         ZkaN4y1W8ieRKgSO7uR+maISSRHHI677NJ98gfrLqIDPyeAUfrGDM0k6TDZXx5oDfpr2
         k3Hq7pJNPDXwkZi2/oeVqChSrJ52SDEzERsOTnmOq6JiPdWjvXeN/1JxDEcRbrCzFBnQ
         8I4Padcjk3jJNum7Aw8aiipf5uEMz2/49s99AFYUdeFbR5VOg54NXtfXJfk4peFDhSCZ
         NBhg==
X-Gm-Message-State: ABy/qLY/2tIluhGiGEJNDzOIbyf+Hgf4Q3wtNoWAWSGUxcE9z+qU/Iy/
        PjhBwD1qqzp2l09+/X+0bDLSl3LSzmySEc9ycP7YcR7jX+0s+u+RDF5FNOvy1tLughruiv+ibNm
        N2vQuzHLp/0ESwQ7h4lFFV27X
X-Received: by 2002:a05:620a:2493:b0:767:6cd5:ec8b with SMTP id i19-20020a05620a249300b007676cd5ec8bmr8376330qkn.27.1688679046723;
        Thu, 06 Jul 2023 14:30:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHgvJsIbhCSjhTrZoP7QXnDNAQZfTuhcVK1JVsu6+bJKK8QySVPVB5tWG6oX59lKUJk0aCmyA==
X-Received: by 2002:a05:620a:2493:b0:767:6cd5:ec8b with SMTP id i19-20020a05620a249300b007676cd5ec8bmr8376305qkn.27.1688679046478;
        Thu, 06 Jul 2023 14:30:46 -0700 (PDT)
Received: from [192.168.2.56] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a13ae00b00765ac1335c2sm1150488qki.75.2023.07.06.14.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 14:30:45 -0700 (PDT)
Message-ID: <eda7b84e56123bce167a64133572440e6806ef1e.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Unregister netdev and
 devlink_port only once
From:   Petr Oros <poros@redhat.com>
Reply-To: poros@redhat.com
To:     netdev@vger.kernel.org
Cc:     pmenzel@molgen.mpg.de, intel-wired-lan@lists.osuosl.org,
        jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
        edumazet@google.com, anthony.l.nguyen@intel.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net
Date:   Thu, 06 Jul 2023 23:30:41 +0200
In-Reply-To: <20230619105813.369912-1-poros@redhat.com>
References: <20230619105813.369912-1-poros@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Oros p=C3=AD=C5=A1e v Po 19. 06. 2023 v 12:58 +0200:
> Since commit 6624e780a577fc ("ice: split ice_vsi_setup into smaller
> functions") ice_vsi_release does things twice. There is unregister
> netdev which is unregistered in ice_deinit_eth also.
>=20
> It also unregisters the devlink_port twice which is also unregistered
> in ice_deinit_eth(). This double deregistration is hidden because
> devl_port_unregister ignores the return value of xa_erase.
>=20
Hi,

Is it possible to push this patch forward? I think the questions have
been answered. Or is something still unclear?

Regards,
Petr

