Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7406A9944
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCCORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCCORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:17:48 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9334861526
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:17:41 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y140so1011869iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677853061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0B3hgicuXjM7bBAtA4QLzoXhHV0rOr+vQWIDTCOLWjA=;
        b=l/kzg3jeG3HJy+mNGRfUhBBZRMcmahd+ieovMaapDb5MsiyeLNeIUaTtcCd2QxFRpB
         50hlspjnf0onhGRXy6jDl9JXkouk6pih0m/SMZlcGTbD2JSgZK3xuKZBW/HmBiY71ugw
         EKX5Fa0gFmm7nLAU3eUT38IJY1PzUtP4bjY/3z7GQ7YgMD272WzU8uvlL1AvVzgbwHhW
         epoOPsAL2/l9oF5XSeF4/bQpGXRB7Md4k4Jj+78a7GWHnY1Xzedilu2sDb4HCRSdwKdS
         QLEWeeWos+wLXQSbaAmRXKjQLca+LhY4ympxPkg4nGRQugEXeUNgQCuQslBTtH8OTg8V
         Yp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677853061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B3hgicuXjM7bBAtA4QLzoXhHV0rOr+vQWIDTCOLWjA=;
        b=5C7BVn1F97oOslWe6MnYKOcCTSNxR1C8rUUYx1GnGcUc9LGIZgkxmXFotMLG0Thdk3
         4gmasI3I/Ow5H7QZhxuBQMUceWr529Hj5DLpAd8W570RXd4UHBKmpqJB4kH3vWRL0+1D
         5gY06dvhVaXSwfmGoPro0YkWZhNtkUBTBuXPmbhpaLSknOKCPQ/A7TIBZ4td7Rn2UZuN
         9J66iLOTFbOefGeCojP87HlGpAd1TjniwWMBnt29KBxNibaaidyHbma0IaxSVxC7XOEE
         q+vxHIqrO8OGVji2hoJdi3gvlSsBrEysjeT1x/tmpQ1c4G6PycWFk5TbBGaTVze7Kqia
         sFqw==
X-Gm-Message-State: AO0yUKUxM8rhk0Z2n/RCaQZRYbz60/YhuaKpaLrj8uyoVu2+K4AzNWOz
        C+y9Y03QInSCYJNWrJaf7V0xmLlBfPeJ2vGwWnw0PKZYmwGFxbiy15VVwA==
X-Google-Smtp-Source: AK7set9X2k1LzfytLPllB3B6kr3vPHB+1IBEeQVW7CBgRNdDRrulQFoARjOl/KTAT0lI75lcKu4uO9Eml0m7CYu/2oo=
X-Received: by 2002:a6b:6a11:0:b0:745:68ef:e410 with SMTP id
 x17-20020a6b6a11000000b0074568efe410mr752461iog.0.1677853060800; Fri, 03 Mar
 2023 06:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20230303141433.3422671-1-glider@google.com> <20230303141433.3422671-2-glider@google.com>
In-Reply-To: <20230303141433.3422671-2-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 3 Mar 2023 15:17:04 +0100
Message-ID: <CAG_fn=XPXOkrh1tXhzvnB+eENj=JF79D9FqJV94J_kpu0u7d5w@mail.gmail.com>
Subject: Re: [PATCH 2/4] kmsan: another take at fixing memcpy tests
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com
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
