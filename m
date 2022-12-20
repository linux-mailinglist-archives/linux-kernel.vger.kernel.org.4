Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE76526A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiLTS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiLTS4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:56:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0113F12AB1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:56:40 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay40so9470808wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPsXopC8VlOGBjVqyvv0STceQYDc5rKNyXXZ+5W5wLk=;
        b=OqHxK/ijy0pwjrnJ7CgrfppgL8g+E2Bcu0/llP444kXxELGG+uatHkv0kONDPi0kEi
         8ft56IFxKCb0fd3kryO7Ov2DWx9jkuYkBps9fPLVWX3FK1m8VX8l91Psekv2KqZCjR1t
         nU1jqUyHU8x++rwNdEVSIaQ1laQ5YRKCQHFeNeStN3UU6qt4pVIOy/NcLC8u7IJZkuvp
         L7ibMa2Cj7fI3e9W5y+3Qqt+a/IX4KIm/RBcDP7rpOXLf9lW4ge4d18cVrQVmI8SgCef
         QaZGdfyrLntWA/80w2k0Yex0cNMGV+IzQsiI5CDeY8dMAIpgBT8nibx31fvW53veRE+T
         mcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPsXopC8VlOGBjVqyvv0STceQYDc5rKNyXXZ+5W5wLk=;
        b=fgxHJ2OqOWCbHrWFjzEeBfyB+4BEHixn0kpUtadum8mTutbRbgG9ji2GD0hqj/xu2L
         vVLzSBR+jDNpmjJl1urAHPZXch8mub7MF88S+GiIbOOGe2mw6BYbetuEpUaN3fBavq2d
         SjDMQLT04xB4pDwNeEvWxbtwL0LjISFlXerkzt/oKW1vJibIOlOKJJwVneo9e0VfWiZ6
         mszHWwRETjHlVjSuzAIPseaQBMU7ZZkD2Fz6ulXBHE3uek/h/xYWrT89OKnH7XXGBH8R
         Y41qaBCq/kKyt8hdJwVF1+CAPOUL0zmTWelzx24QHXbLhRW3esoBAJC/3DO+wUByJ2FG
         MxnA==
X-Gm-Message-State: AFqh2koC2/kL3MYpN/ERf07dfML4tMwYEREaChzOYJTiVmiWoifo0xTr
        hFStJzRz57CJSuigh7Z4/Lg=
X-Google-Smtp-Source: AMrXdXu11W1GwRxdfJAqPTr6zCnU20ODFhQVmowwREDaFmTSTS7SG34Ko2229fWjO5IpJxn/erV3hQ==
X-Received: by 2002:a05:600c:a53:b0:3d3:5d47:271c with SMTP id c19-20020a05600c0a5300b003d35d47271cmr4087178wmq.12.1671562599405;
        Tue, 20 Dec 2022 10:56:39 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b003c6bd91caa5sm16874912wmc.17.2022.12.20.10.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:56:38 -0800 (PST)
Date:   Tue, 20 Dec 2022 18:56:38 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] mm: vmalloc: Replace BUG_ON() by WARN_ON_ONCE()
Message-ID: <Y6IFZozJxCkMTorA@lucifer>
References: <20221220182704.181657-1-urezki@gmail.com>
 <20221220182704.181657-2-urezki@gmail.com>
 <Y6IEnojgQtQcUgDe@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6IEnojgQtQcUgDe@lucifer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 06:53:18PM +0000, Lorenzo Stoakes wrote:
[snip
> Absolutely in favour of this in principle (BUG_ON() is something we should
> resort to in only the direst of circumstances), one small nit - perhaps it'd be
> neater to simply make this a guard clause? E.g.:-
>
> 	if (!WARN_ON_ONCE(!va))
> 		return;
>
> 	...

Made a mistake here, meant to say

 	if (WARN_ON_ONCE(!va))
 		return;

Of course :)

Apologies, only just noticed you are sending a v2, perhaps something to consider
for it? But will hold off further review until you send it! :)
