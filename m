Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4964D601C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJQWUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJQWUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:20:32 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD7FB853
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:20:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n83so13702729oif.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XCkS1qGhXwo9kRvJGMNGDgeFxVYPntJNEc6NMfUJX8=;
        b=LNVvBCx2iy1p0xTEMF+HvFUuFXBheFf5i8ThaW3nNp0JO80SwNwQ78rtGgL23SyV5q
         ONfrxMTIOzwyUWiMHsonqA0IanyV4cz7xy3miT1Ekt3AF2g1N9GFWuNTiOnbypsHzbnm
         BocH1ZoKo7qysNVxzrjkfHV+wcgYHc9DHbwsLb+PeD6eX2Pa63mZcIm9Nk+Bx+fIsyHK
         rLvigNiB8vMfyDD5TTOVlZlkvpOB0mJpr8eri5N2Ekmou6rXMKCPE+pkEW84vZ3BY7tP
         FFHXUzq/JhYs1JYgCk8ze9TpLdcSCPLljFW9rqcSo4KDi9i5BJminoZXg+ieTD10U2Mf
         PWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XCkS1qGhXwo9kRvJGMNGDgeFxVYPntJNEc6NMfUJX8=;
        b=rcE5r7IMq3nFJmOevERsWp1gd0fxoRkpRvQM4j502WsNVjDudAtjquiZBphmn6dy1a
         eowjQcseeJemLu771GlNneJjtEZi2BywD3+UB5pvFBO5anPB/YkDEqHZZoWJ3DGFNGId
         IuGSpIqHmDwV2CIZWOsGxA7y5+ryjzQFokVnJ1RqW5+Oyu1XkFQ64lqNvgZbNSNRf/Uw
         Fr5gnmpDEbAEYCFVC1GzjlYIiPeN2/YHZkAsn1XJCeepCOMKpHn2Mjwh7NAqt9zNl5OW
         5R7IysWMYa1BkEh/iSZgAo9kT95l9eyF0BHPKQ+mcS7Skq+PCtBv3iH9YynHM4WGd+Aw
         O4cg==
X-Gm-Message-State: ACrzQf2SUefgjwVLGa1mTczCLYRNHkC1SBozSu6+celIW3RPhLsjcggs
        QLH1++DqBzXe4Y+050sUw/rrvQReUvzVFalS
X-Google-Smtp-Source: AMsMyM4KphC9FgnetxGE3ny7SW2d/ip2E5FkfZC/spdLS9nYyXbXazn0Y4AtqNRQp8rmj8mNhBuDLQ==
X-Received: by 2002:aca:6109:0:b0:345:3bd7:7f4d with SMTP id v9-20020aca6109000000b003453bd77f4dmr6099526oib.69.1666045230176;
        Mon, 17 Oct 2022 15:20:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id q28-20020a05683022dc00b00661a0a256ffsm5278896otc.81.2022.10.17.15.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 15:20:29 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     andrew.smirnov@gmail.com
Cc:     andriy.shevchenko@linux.intel.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"
Date:   Mon, 17 Oct 2022 17:20:27 -0500
Message-Id: <20221017222027.14223-1-steev@kali.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAHQ1cqEAqRx092Ok9uRUpQCuGHAhkq08W78OFst22Ej8ZmmAsQ@mail.gmail.com>
References: <CAHQ1cqEAqRx092Ok9uRUpQCuGHAhkq08W78OFst22Ej8ZmmAsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Unfortunately, the reverts have already shown up in 6.0.2.  I failed miserably
to reply in the thread correctly, but these broke USB and a few other things on
my Lenovo Yoga C630.

Reverting the reverts gets things working again.

-- steev
