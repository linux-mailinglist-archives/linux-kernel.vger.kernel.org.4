Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE796D28B8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjCaTei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCaTed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:34:33 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC626B3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:34:31 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id g17so20041046vst.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680291270; x=1682883270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5aI4zIcRoRLxHWt+SS9DifZOEmMBwiP2WMG4ZM+Us0=;
        b=GBvj2VVzqcz8cM1eZWgTv9CGJbCh3zsVEDpjDHXkTESlN0fjtf99vxFgjC7OHKg3xK
         H4JCfx5akPv1CZRSefFIb7I885BGidHlru/Ddntd6dfR7S1DLZVhd5wIHsq4TSG446sp
         RhyGidbX74IyLJo3hc79hGmAzBWGNfFt6e4do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680291270; x=1682883270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5aI4zIcRoRLxHWt+SS9DifZOEmMBwiP2WMG4ZM+Us0=;
        b=yzU41Lemv7WIP/S95mNG6YK+ERsPGtuEpxgVRjRPitp7T8UEe4+O3xlXdvPNrEnafR
         TC4KnWCXuQp6ivgly9TCJrEQJ4JrZLOkDOFGvIuwR9oYeHbwAmDG5hd0aj0+bqy73Cc3
         vxy0SIvgM0cT7zdV8pbejalWY6dMno2SfqKWQqKv7LD5Dwsp6sCFzQGVArr8vn3Isx3F
         ASp5INiDX5CuTlwh6bQ0NcMkBThRyN2Yrxh6L+tJmh8GiYV0Fl6RSKu/rKrMFdvwTISc
         dTw9QhJkk134698aav86Q/lkdU7uBpbHJmz44poYf2/KYAa3UKCetTylhn9/Demf6iQH
         eKMA==
X-Gm-Message-State: AAQBX9fuJ5R69wvSNbtQOGBDhFwU+MKLWGHBMrajvoA146iuUBzobb2v
        J4t1qIQHjhF70BRj6KyFjA4Pfhf+a1dvPZbh2xB+9Q==
X-Google-Smtp-Source: AKy350avAB5zM9H9xCzxvaea8vrZmf27YUrlGiTRyv7e4+dWXsw3Sz6xg7dkenWal9cIF2zXy/xEIE/sEnOmr8Fg7YY=
X-Received: by 2002:a67:e1c4:0:b0:427:2159:370f with SMTP id
 p4-20020a67e1c4000000b004272159370fmr2538299vsl.3.1680291270429; Fri, 31 Mar
 2023 12:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230329220753.7741-1-mario.limonciello@amd.com>
In-Reply-To: <20230329220753.7741-1-mario.limonciello@amd.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Fri, 31 Mar 2023 13:34:19 -0600
Message-ID: <CANg-bXDsYffoYz+VL9hWkhOAyXKXDDLmB1rAvyahf7GCGibfVg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Use CCP driver to handle PSP I2C arbitration
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-crypto@vger.kernel.org, linux-i2c@vger.kernel.org,
        Felix Held <Felix.Held@amd.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Mark Hasemeyer <markhas@chromium.org>
