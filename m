Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569636FD54F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjEJEsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjEJEs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:48:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5FF44A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:48:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ab267e3528so47902365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 21:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683694107; x=1686286107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbCygp9Px15SzD0gwBSvyFIkLYldAjH2gcy9VS5qfBA=;
        b=uu6lxeulBsClafDoba1z7contnPxyTG1azE0iMo1TkJbWonAvbaTxSSqU77lmI7wWT
         Jph156IIkUs8azw/OCVukwlBzQlXLpvAMhOFSlE0ehSRebZAH/C88rZo5hXHhVYKECH5
         UyaZOxOLOs5yhly6OZuiPs/Lqf7gX9fo7bQZKcSVhz0jqpnEr0ezGjoV5irN0vAVv9j4
         I3DhZnRI9d8SgOqq9lCkraqzopceA2mTjfd6Aa5Cdi4ZPuvFXVnaGonXhZUz3jsQhPJz
         YmJW5BiFrBwNokCxWTFeoujgAj9VJP7+HQxNHENIhxHOTFXnEazYPZwkIq75367w66Hz
         pOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694107; x=1686286107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbCygp9Px15SzD0gwBSvyFIkLYldAjH2gcy9VS5qfBA=;
        b=eJ88FCBlwa58nVy/7VwzIaHmYRRJboM9kYK7QDfneypQZUE5ZHq8B50Nn8jIOUdAPf
         4N6hYVViryg4xeDGTY9fqxzRAV5Drch2y/3jcrd9pl8FY3xRvLjLOnEX8EoWilp/xx1r
         WRgEeFKEspe03hoM9/GXLMOl4Kf7os1vf6BQKNaZhBxecQQDbu9dmw7AWRXV79FshPB2
         qDRZx4FTfmkgfUCdXJROAgeX1zUDtx/tDFW4s4UeCfQawzrumA6s6DUmyHVClw3p9dV6
         nVpzbdbZjVhV5MbP5UAZFeHVRCwBbkilA15SE0RlNINNJEz2+Wv7+Q2H702xYaM95mDN
         8yVQ==
X-Gm-Message-State: AC+VfDzTCbsiJ7PQ8kli0kUF2Hmfejno30KZsDkbzvU1B90cHqVQQ58H
        XFbGCpHnjiiH3vwKQfdDST0uln+eahcvRPTQH+s=
X-Google-Smtp-Source: ACHHUZ5FtHw6VRGWfuSyZnM7yVwB2RqJuk4iYxi7e2TddgcXvPXkQJmL2Y02fkXItbGLSqa0mfRjRg==
X-Received: by 2002:a17:902:dac5:b0:1a5:dfd:d167 with SMTP id q5-20020a170902dac500b001a50dfdd167mr20566017plx.8.1683694107319;
        Tue, 09 May 2023 21:48:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902aa8100b001aafb802efbsm2613503plr.12.2023.05.09.21.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:48:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pwbkW-00DUIx-1t; Wed, 10 May 2023 14:48:24 +1000
Date:   Wed, 10 May 2023 14:48:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 21/32] hlist-bl: add hlist_bl_fake()
Message-ID: <20230510044824.GG2651828@dread.disaster.area>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-22-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-22-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 12:56:46PM -0400, Kent Overstreet wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> in preparation for switching the VFS inode cache over the hlist_bl
  In

> lists, we nee dto be able to fake a list node that looks like it is
            need to

> hased for correct operation of filesystems that don't directly use
  hashed

> the VFS indoe cache.
          inode cache hash index.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
