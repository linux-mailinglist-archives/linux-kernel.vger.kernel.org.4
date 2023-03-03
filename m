Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D9D6A9942
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCCORf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjCCORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:17:32 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4D26189D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:17:29 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i4so1685626ils.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677853048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0B3hgicuXjM7bBAtA4QLzoXhHV0rOr+vQWIDTCOLWjA=;
        b=FEDTdi5M4UbvAjDjLdirfZeZX4i1T4/SUaRiFkc9eDJ4CmM4S6EZEIBxvUj3R6ZmjX
         oLFwjQ34KvQsUjCWRXi3ow59Q0jsKTTfQuqoPmtyOWwPXk/8UDgK+7OeFv3nr1L35RjH
         n/iftKxAinqCtZD9xy+cc281yM5sMGV2k5V5zJyvivq6Bx+my4thB0nlT3ZLCrDM0LJz
         kDhd2jBc0x9TzY4BIkZQIUOO92JWscSjqi4vvH8FeDgdkAWjSy1wvioEAXcYhzg7wOhq
         JdxyjpANK+j82SMAPmoSULgTfakGhtDDPYXw3XvnjK6Vt0titZTdD/5KsNq109vE0TK2
         PsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677853048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B3hgicuXjM7bBAtA4QLzoXhHV0rOr+vQWIDTCOLWjA=;
        b=XJ0nglpWAPt6MXH6/zmgsWGdjydlyntyB3sws4oGPNQAP+16EWeKAv1SbvW33rAwgT
         AnpI6qkD2xUaTmhp5sRRvKdpllwUUSVDjCLs9s3ED/S1zsd+esg8XTOGbBv29GNsypMa
         i49NZ2bNCybU0AvQoGb3U8y7u0PG2wqt2Icikw9X4FMxWKKUhy40y5iBStxSZOTVQEmZ
         NDBU9duuR6sIjynTlXzinbovvfYV55gYR6se1YWOJwAHqRV2k0DYNXmxq7PX6eC+U8pI
         tKChO0QeOdOeqxrJrOESwZ3/ck85UtXRAyveLBJmlW7IhaczPtvgQfIOG4OJ2DPEywKa
         EMNQ==
X-Gm-Message-State: AO0yUKWpZwxBiIPJGJrA/RtIB88sPh9NY/b/nsVd71ehd7yHecRhiLrx
        iawWh2qvJ/9Uit8rp7TVabLBUKMXGF4IVgeZotLTqiWwS2FwzungV1Q=
X-Google-Smtp-Source: AK7set/pFerOWUN4tr/axRgYVrZuN/EJU4XtfaGKPl3oLswGy9l5hX2OOIs1voI9F8iYPiduE58uMoVEkop/8vVHsj0=
X-Received: by 2002:a05:6e02:130f:b0:315:9761:6965 with SMTP id
 g15-20020a056e02130f00b0031597616965mr917889ilr.5.1677853048407; Fri, 03 Mar
 2023 06:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20230303141433.3422671-1-glider@google.com>
In-Reply-To: <20230303141433.3422671-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 3 Mar 2023 15:16:50 +0100
Message-ID: <CAG_fn=X45qBJKgaZ4xVN=DHwDTYG7HzUb5kTwf79Rs1aJ-f9mg@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: kmsan: Don't rename memintrinsics in
 uninstrumented files
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of the patch. Sorry for the inconvenience.
