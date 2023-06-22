Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E288739894
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjFVHzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjFVHzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832F5E75
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687420507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Eox6kzJ0KXGmAxPu1zCtO8SWj1o8YH/kpH0QF8X1TQs=;
        b=AvjvZFGq1D7F7kUm268mcKadsIlbaY53/rkh4kIe+5SKdZhN7hAKdvXu2NWUL2Duh/3dCp
        x5PhTAYrIRGiM5SSFTg3GJC8cHwPbBQnP2gFizLH1+v5pEib3GKTt7gvXk6GOLUMTNq60T
        /UxeqN4VAShAnvCcGJTjAj0D2aq5f/M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-bH3rKUNVNvyZqvaCjX5MIg-1; Thu, 22 Jun 2023 03:55:06 -0400
X-MC-Unique: bH3rKUNVNvyZqvaCjX5MIg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31273e0507dso1843812f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420505; x=1690012505;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eox6kzJ0KXGmAxPu1zCtO8SWj1o8YH/kpH0QF8X1TQs=;
        b=Tl07rGYBTjJ/hWlyuK5NzJwqZcco+09wvN/H2IL5/UTQfVQ2yRDLgv9pLcUzV7F4Xc
         nDYqUSSko8HN86fGIZFdiKnuXUy8v88VaThZREB6q6DgNCBmoKCGiZ6M1coWVoqeFUoO
         xUa8lKYnbNNo7nWH1cTNQyNuoNlPbfR7lBrk7rN3dPqPMd99917CqQw2q8nBGNZJJ7rV
         iv0KskZkg6xGJ4WPeDjx/2r5dK/HMfEjKjwJQlddg8blFqV74si+RHGMu5H4bfK8FDnP
         Yy0BHVCrM9zfimqypqb1lLt+Vpb8kzROe+8Uiys2j5FZ3tshunG5I9669MWCiLwdwWlP
         xQew==
X-Gm-Message-State: AC+VfDzAXosWBQY8KFGvqojjAQBovQGxHgmD2HxvIc6jO5MM8It5E+wD
        3FtKvHrWCSzNDKm5Kus94qtBbayDdCDPwADRRvPQGoksojo9+eLkv5t2nmjXCeV9dIFVo00LR7v
        POTuthr5LurCcK1Ym1cEYqAdL8twfKozIhnzzsr2M
X-Received: by 2002:a5d:590c:0:b0:30a:8995:1dbc with SMTP id v12-20020a5d590c000000b0030a89951dbcmr13481437wrd.26.1687420505050;
        Thu, 22 Jun 2023 00:55:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5XXdP5mBFYeXjHFqCUFXHfOsqZzMCP4KunAaLqWfIWum2C8ZQg8p8aPknYzd7pBcBBJ2gzkZCOOq3kQ/vNoxc=
X-Received: by 2002:a5d:590c:0:b0:30a:8995:1dbc with SMTP id
 v12-20020a5d590c000000b0030a89951dbcmr13481390wrd.26.1687420504759; Thu, 22
 Jun 2023 00:55:04 -0700 (PDT)
MIME-Version: 1.0
From:   Vitaly Grinberg <vgrinber@redhat.com>
Date:   Thu, 22 Jun 2023 10:54:54 +0300
Message-ID: <CACLnSDiBML3R_K5ncFsuritvid5nGsBLx5pGR2c9pR9L=qhPiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 00/10] Create common DPLL configuration API
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc:     David Airlie <airlied@redhat.com>, andy.ren@getcruise.com,
        anthony.l.nguyen@intel.com, arnd@arndb.de, axboe@kernel.dk,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        claudiajkang@gmail.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, hkallweit1@gmail.com,
        idosch@nvidia.com, intel-wired-lan@lists.osuosl.org,
        jacek.lawrynowicz@linux.intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        jesse.brandeburg@intel.com, jiri@resnulli.us,
        jonathan.lemon@gmail.com, kuba@kernel.org, kuniyu@amazon.com,
        leon@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux@zary.sk, liuhangbin@gmail.com, lucien.xin@gmail.com,
        masahiroy@kernel.org, michal.michalik@intel.com,
        milena.olech@intel.com, Michal Schmidt <mschmidt@redhat.com>,
        Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org,
        nicolas.dichtel@6wind.com, nipun.gupta@amd.com, ogabbay@kernel.org,
        Paolo Abeni <pabeni@redhat.com>, phil@nwl.cc,
        Petr Oros <poros@redhat.com>, razor@blackwall.org,
        ricardo.canuelo@collabora.com, richardcochran@gmail.com,
        saeedm@nvidia.com, sj@kernel.org, tzimmermann@suse.de,
        vadfed@fb.com, vadfed@meta.com, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
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

Hi,
Could it be possible to add PPS DPLL phase offset to the netlink API?
We are relying on it in the E810-based grandmaster implementation.
Thanks,
Vitaly

