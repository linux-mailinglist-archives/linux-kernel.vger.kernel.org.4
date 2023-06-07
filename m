Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75F0726510
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbjFGPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjFGPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13021988
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686153154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TOMl/zsYsxHhpDF/HRTWo8jQ2MtjI36IUKMO+lfdvXY=;
        b=ifhXyd/KGlYxZXP40ekQa8oPBw2l46ZK0XClMGQap7Wi17ncY+oMszq0It2PG2ONIn9EKb
        MoQajRhh+FKuxL23s0TS8Muz/pymi9FR741GrAgr1VJcgDvfGlZwwIBXZ7JP4k9Irjh00D
        BSPj8qnXlsjPzbN9h3RRKQhG1qAL45g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-7oEkNrSOM_SgyfS2_maFuw-1; Wed, 07 Jun 2023 09:49:22 -0400
X-MC-Unique: 7oEkNrSOM_SgyfS2_maFuw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62b683503e0so2741086d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145761; x=1688737761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOMl/zsYsxHhpDF/HRTWo8jQ2MtjI36IUKMO+lfdvXY=;
        b=AymGFEWNX27hy8Ai4ssLr3sw5OQyIVARB7sOKmh1RvcsonqOr9nH8CL4dtL1TVxAD5
         nFk35/eNYD+YpMs1BGXsIXGfqN66RPy8Bop/sKbKXrDn879Db+NZGTO1l3gNQ1voZIM5
         Xi/v+9ixO8GqC3pQedaFCHuKLPOuaAdaVAp1xLg2W2S17Qy4dYhqgQbyid2PqS2b802H
         ZMsjy0RNxqrcJNPnReZofRRxKH2E5m3J2qblJm/Rpfv8wvrJyi1lvcEhRs5snzUeEeai
         mH4y+xYRyPRz8nOub0zpKDHOYd/ih5egKTu9poJZXwKyOKJBrL2EWKykFjoU8C+SyBd0
         b98g==
X-Gm-Message-State: AC+VfDzN/hwnoEr8xpd/6H+iYSTSHpKt2cEUti6S6ngkWl5w8j20U0ms
        amJgqz8atqOaMBcDqOfLUwxpiLqbwj1dnq1/TbkL6ZZcNcsss1642Wh0QMPybAUHGAasH8yd+Lv
        jnsE2tgSltndYqgmiJEL8MiL9FRxlegkORLu5KLVkp1i2i+BIYjAYgl1DENU0tJwG6hfFHcM8Ux
        tYNTyUFg==
X-Received: by 2002:a05:6214:c84:b0:625:8684:33f3 with SMTP id r4-20020a0562140c8400b00625868433f3mr2033066qvr.0.1686145761178;
        Wed, 07 Jun 2023 06:49:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nMOwhYfHdLXuXD1RGQTNb+w15jGAMSPI+RCRgx2AhZB68xtY5hPsk9NmQcgH2AoAjChg+zw==
X-Received: by 2002:a05:6214:c84:b0:625:8684:33f3 with SMTP id r4-20020a0562140c8400b00625868433f3mr2033036qvr.0.1686145760744;
        Wed, 07 Jun 2023 06:49:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id mx8-20020a0562142e0800b006261e141f4bsm6112174qvb.87.2023.06.07.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:49:20 -0700 (PDT)
Date:   Wed, 7 Jun 2023 09:49:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 0/4] mm: Fix pmd_trans_unstable() call sites on retry
Message-ID: <ZICK3uqTeUxeIlc9@x1n>
References: <20230602230552.350731-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602230552.350731-1-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 07:05:48PM -0400, Peter Xu wrote:
> Please have a look, thanks.

Hello, all,

This one seems to have more or less conflict with Hugh's rework on pmd
collapse.  Please hold off review or merging until I prepare another one
(probably based on Hugh's, after I have a closer read).

Sorry for the noise.

-- 
Peter Xu

