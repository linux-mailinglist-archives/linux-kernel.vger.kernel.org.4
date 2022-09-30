Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C55F01AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiI3AHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiI3AHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:07:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D031F8C02
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:07:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h7so4419837wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OOD5GnY+yF8XWuvuXRG/SQcRpqNEynD57yvkex+WpCc=;
        b=JBzYiWFqqHK9Kdwhzv0C4cHQa5kbDyO+UJ72ST/JX37WcxS7/X6uWsu0JDXmz5P43a
         57cDakWWJrSrPy106baUcgWHrNpdMMMjuK3N2WWgYYsQRtEMKTqV/KLMnNwv3c7wcfB5
         04R1oY1G8eXSP+rYISlEdZLed9SY/CaYSMt2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OOD5GnY+yF8XWuvuXRG/SQcRpqNEynD57yvkex+WpCc=;
        b=i8d3sMxrE/JlaLbJXjrV29bdYOXhGuMU39VXvOcB60XEbmdHLlaiLltaC8h0iPmqr+
         KL4Bbsb9SdlGIcAeXaMq1u/uDWq1BcVOGAQqPLr2hGawefKEQitJx2sV4yBMl+EK9urY
         nwyvEiaIh4cHhDIhTUIpwhSdiMe8GmXRI2s1Qpxv5DVwkExAJWt++v3lmzhGHmxf358G
         /WZTMSm3xM7WaDZ4kJViaGJ032SZ9VJGOlpBVPb/Pj6DLfph98OhkFkPtsVRWuFU2TRG
         Jjlp6HsB0NXVfeiZ/lnGZn43MqnrsKobujWVlrnUHx2jx1HYLWsh8KpL50q7bW2J5sza
         G82g==
X-Gm-Message-State: ACrzQf2PioOSs/xLFKO79IBlWPs2PsGaE3jUnk7jAHCAxUVeLS98C46/
        i4MfXOyT73z2Jcb3vKwCTnsRbem295Dqlw3qKvzagA==
X-Google-Smtp-Source: AMsMyM6uXH088zkRixid53ROdQNJyn49XoY8VID40LvNkzwVUz+44PxtT0o0C3mveJ+VL4Y8laPfX3GdGYngxzjsYyU=
X-Received: by 2002:adf:e187:0:b0:22c:981d:5528 with SMTP id
 az7-20020adfe187000000b0022c981d5528mr4016430wrb.407.1664496436338; Thu, 29
 Sep 2022 17:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220927205551.2017473-1-jrosenth@chromium.org>
 <YzPmKF6LRwXVua3X@kroah.com> <YzYwz8puWz+zcaF/@chromium.org>
In-Reply-To: <YzYwz8puWz+zcaF/@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 29 Sep 2022 17:07:04 -0700
Message-ID: <CAODwPW-mLtEjpY1c2rYCOncyBN0=Vk4iqKUqZTQt=is-hxSsMw@mail.gmail.com>
Subject: Re: [RESEND PATCH v10] firmware: google: Implement cbmem in sysfs driver
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Will this work for all coreboot implementations?
>
> Yes, CBMEM has existed in coreboot since 2009, so it'll work with any
> non-antique version.

FWIW the lb_cbmem_entry tags that this implementation relies on are a
bit newer (2015), but the basic sentiment remains. This is just meant
to add support for the coreboot versions that expose this data, it's
not going to hurt earlier ones that don't (it's just going to create
an empty sysfs directory for those).
