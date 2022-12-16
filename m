Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD61864E4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 01:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiLPAHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 19:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLPAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 19:07:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA65C0E8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:07:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so3067486wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqPcwVxwL0VBFQRCmUqDqusJfO9KpSKQyLCRAjfF6Bs=;
        b=n/U6PP5nEJJpL+hlfLVNE3eAYwRJ799seU0k1HFiHT3ihN/xuWwSIifl2pu80Qy8sm
         K1QcCepzNnQiUqlwX0I5+2rOigix5kWugnwDQp1J8XhtakJuzXSFBbml0mGHfgKS4blK
         aF2QRv5NC2Kdf47co7n9kvRLLnBAUlTp8EGGVb9TYGjv0QlFV5PQFpQjFft/ATVokHNG
         Ylb2x52FY35jVwhSz6Gq8KnqEJRaET5/HoL2QxNbhhZQkoNXByA8LFNIlgDnS8/d5pgb
         jHtv/0fgDbb5QknyWuT/46tj04lK1E08n8a/K6HW8vt6UwPFHxRR/VkwqytF2pcYr4m6
         9nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqPcwVxwL0VBFQRCmUqDqusJfO9KpSKQyLCRAjfF6Bs=;
        b=r7NQz0HoGiJ4aEgVrDsP55boUAo0oubT/h/C9SRJvsy5x+gBklaz01HyvKpzeLL6w4
         YeJ/2Er0tU67a+F5xSNG+XvZVerhRXpkNR7Pf0p+DjYhhrjfnm8pjNzQCxapji1O8GmK
         DxNRWk9RYF9/EbgxSu0gBg/zEOSzh8qDd6mJX5J1mtvDD3+IzQnA8yAwrD7jqPMzXqkF
         fcOB1QMOfIXXBbfNwyEFCM+TEy1jixpZnidLCIXRlDfrQLh+vWY342Oafl2hwC6n67c7
         bXcqhjvUvEJ2+9HfVQI9mHNnnA4Icucis5300mxgb4PFhoiWP9prVpDYtq/kroTMosVr
         mVFA==
X-Gm-Message-State: ANoB5pn8RhU4BSc71VHp4YjUR1YS7x+ynqqlY2qi8u8REj5/tTG/pTBy
        dL8C+9wgRgYVkGRtctz25bc=
X-Google-Smtp-Source: AA0mqf4MoBf+40dEzatBH+UMQ4Rf2pK8RAlre6QJT7+CyGXEDYfBHKrOYIUpzlf5oxXmh0JBzDgiJw==
X-Received: by 2002:a05:600c:2ad6:b0:3c6:e63e:8163 with SMTP id t22-20020a05600c2ad600b003c6e63e8163mr22793558wme.26.1671149222401;
        Thu, 15 Dec 2022 16:07:02 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id j41-20020a05600c1c2900b003b4ff30e566sm18891105wms.3.2022.12.15.16.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 16:07:02 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     tiwai@suse.de, linux-kernel@vger.kernel.org
Cc:     Joan Bruguera <joanbrugueram@gmail.com>
Subject: Re: [6.2][regression] after commit ffcb754584603adf7039d7972564fbf6febdc542 all sound devices disappeared (due BUG at mm/page_alloc.c:3592!)
Date:   Fri, 16 Dec 2022 00:06:41 +0000
Message-Id: <20221216000641.11071-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The one passing the __GFP_COMP flag appears to be sound/core/memalloc.c,
see also commit e529d3507a93d3c9528580081bbaf931a50de154.
Removing the flags also fixes the sound issues and warnings for me.

*Resent with fixed Message-ID - sorry!
