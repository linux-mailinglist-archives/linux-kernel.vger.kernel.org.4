Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9F70AE45
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjEUOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEUN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 09:57:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B7C9C
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 06:57:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f475366514so33415815e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684677456; x=1687269456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IZ0+A20S9i4vsmJVu3SMU9ONVfr0Mn1VLo9H2/PkYg=;
        b=mfjpjTnSjrraX6wSw1VqZPoSlQUYds0j5RVTeUZvgl4eazAtKtZMDclec5O7b9AACJ
         OR3vnQV8B7H5BU1RpPDX0IPHDnD2M3LPs2818ZU8rkl4mB9+GIu1qfbjZPNvKvS9aWpv
         VgS6l8DFX5QKsDkrpnokeNsttz9fquyppptD9K7Z51oLTkoUyL3Ci+iupRBYoilNJ8QK
         b5AvnAgiEksQgGeDioU+yZ+c7vjbOqWUfENblcnkAq6Svu7w85fRlJpfXKtJ7ATdV4Sv
         wj5p30Z73A3DjwYkYgucVIlcd9VRkHMoj/jO3lKbPTUj+40aQI6OSH2v0AYgtP+2XXtr
         MaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684677456; x=1687269456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IZ0+A20S9i4vsmJVu3SMU9ONVfr0Mn1VLo9H2/PkYg=;
        b=Jhq6EHUU8AJBiu8ivEdkoDfEdBDkPBp68Rd95ilsU/I4/YtVVX5c71td24zhP+yFrB
         hSTmHwU/0J2au7GOdGqCBQZ4XMdR7HFZxdk+bYqRw/OK6RreEf9uFfgkIlZbYt6cQDFM
         mZKp9qEUh1tzhYR/POC+puFcbqbWwlA7T4eK7nLEItPJIapPlL++kIpNrQTxYn0I686T
         QlCRLE6bEdD1IcUxYqBkhEPKJuUyHXjem3V3Tc9JzQ2qd2hDd16XYN7XNAf2XKx8k7u4
         dybP8IEaUZwIH2bjQgnyBZXkQEAA8RPpAfxEYpHXWzBt3SmUACT04PojNeqJLRjKNdkP
         mppQ==
X-Gm-Message-State: AC+VfDw3XGhMX2cnqoZKnmYhWrRIrfyR/E6aJNZ3OMQjSvFIZ1LS4VEA
        fqsxRhd305NXbeACJtm+CX4=
X-Google-Smtp-Source: ACHHUZ7afx+Sddu7qd91bjzXnmT7lURCcBuyJE+991XKC/gxiCqM3ABLBv18C/RPLbqa6wm3W6W+Dg==
X-Received: by 2002:a7b:cb97:0:b0:3f4:253b:92b3 with SMTP id m23-20020a7bcb97000000b003f4253b92b3mr5133092wmi.18.1684677455507;
        Sun, 21 May 2023 06:57:35 -0700 (PDT)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d464f000000b003012030a0c6sm4756925wrs.18.2023.05.21.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 06:57:35 -0700 (PDT)
From:   =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To:     zhengqi.arch@bytedance.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: shrinkers: fix race condition on debugfs cleanup
Date:   Sun, 21 May 2023 13:57:33 +0000
Message-Id: <20230521135733.1076395-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2d44a1bd-eb80-7724-ff4e-a0fc3bfd8b72@bytedance.com>
References: <2d44a1bd-eb80-7724-ff4e-a0fc3bfd8b72@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/3 13:37, Qi Zheng wrote:
> > +void shrinker_debugfs_remove(struct dentry *debugfs_entry, int debugfs_id)
> > +{
> 
> It would be better to add a check:
> 
> 	if (!debugfs_entry)
> 		return;
> 
> > +	debugfs_remove_recursive(debugfs_entry);
> > +	ida_free(&shrinker_debugfs_ida, debugfs_id);
> > +}

As a practical matter, both `debugfs_remove_recursive(NULL)` and
`ida_free(_, -1);` are documented as no-ops, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/debugfs/inode.c?id=0dd2a6fb1e34d6dcb96806bc6b111388ad324722#n748
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc82bbf4dede758007763867d0282353c06d1121

Sorry for the late reply (the patch already reached the mainline tree).
