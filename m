Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4EE6687F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjALXxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbjALXx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:53:29 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19C5D684
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:53:29 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 36so13871286pgp.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pk1WVm5dvtYH/mwajur+NJcCrYzh+DAnEkimMVIy09M=;
        b=iGBimbDp5/PNNOdg9LFjc1OKGbXYRy6qlVh9AdxQCBMCuyFrRLrnif30WM8nsbIU0o
         2PWiDbXGNVNdRq0F5Julg7piQJYnKlsnizyjMksLnezGehQCUAdKfj/4eLBEJySzoXNA
         p6CK39NLIxvPQkYt5XLYJ9URwxXZAVRp6pMfvIvNnUPOQjBkPX3DyUp92d6wwH9GpHNT
         at4j2g9Zh/b5x0r6jl2Uiw9xg/t0dBI/KthxCT7RYqyp2YQK8Lt3K+aL5LYLpSWf9rd5
         VnV1jFBbo2RmcHgbn3DIAQ4d1s8muZoxS5sxbX+sVBcPIHg6v7PHXuy7uRmfSLs8fIj4
         RpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pk1WVm5dvtYH/mwajur+NJcCrYzh+DAnEkimMVIy09M=;
        b=JG+5+gTjyDqQK4P9EjPqViPr8zVVoMaYRErT4Sf9cfUtLJjyOROA1DS1rhZMWzveag
         ZlTNofqMTh+Zy58IvhNAOOmtYlcBhJ/E0y2upLkLVSW/WqIn2UERanhSXc1gVRJQAQ5P
         oD17MB0JzIyKYKhD4KTzmlppHATZ4vd0zBMMrsjwe5gb1j2Fsuvox94/D3Zs6Jt45OKB
         Ebt1vS9LWJUTOLQARISuwhx0gM97TL9H2ogPrp4PNrrATeJm2TfqryfoweQmX0uQLYOS
         8KNV8lqxKGFc3uMACWk2P8PHXt3BG17QO1VcTJPDO11JcHewHI1OlaZZdqaxZH7QNxHu
         yNUg==
X-Gm-Message-State: AFqh2kqyCXy/LYXO7NiJk0KJOcgc+sLLLrUFglp0SX+KlmY3BhCPQYhH
        Egd9qk8o2Fgm5jv7zvCqmFxxbg==
X-Google-Smtp-Source: AMrXdXtLCwHJganUQG2JFIqhGBfTvpC8aH+dcUesUbQKB7sMQs1XC9Yma8a7vr7eyQ+WqwALlEfiPw==
X-Received: by 2002:a05:6a00:a87:b0:582:13b5:d735 with SMTP id b7-20020a056a000a8700b0058213b5d735mr1107029pfl.0.1673567608463;
        Thu, 12 Jan 2023 15:53:28 -0800 (PST)
Received: from [2620:15c:29:203:1f3b:d48c:199c:9f57] ([2620:15c:29:203:1f3b:d48c:199c:9f57])
        by smtp.gmail.com with ESMTPSA id y24-20020aa79438000000b00574ebfdc721sm12861377pfo.16.2023.01.12.15.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:53:27 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:53:26 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     lvqian <lvqian@nfschina.com>
cc:     cl@linux.co, penberg@kernel.org, kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/slab.c: Delete the if statement
In-Reply-To: <20230111092744.112038-1-lvqian@nfschina.com>
Message-ID: <1848b8d7-f40e-1851-b2b1-68c3df8f0bb7@google.com>
References: <20230111092744.112038-1-lvqian@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 11 Jan 2023, lvqian@nfschina.com wrote:

> From: lvqian <lvqian@nfschina.com>
> 
> 	Remove the if statement to increase code readability.
> 
> Signed-off-by: lvqian <lvqian@nfschina.com>

Acked-by: David Rientjes <rientjes@google.com>

Will rely on Vlastimil to remove the spurious tab in the commit 
description.  Function could be inline, but no strong preference.
