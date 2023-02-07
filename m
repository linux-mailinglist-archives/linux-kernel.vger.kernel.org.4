Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A3168E09D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjBGSwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBGSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:52:49 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CE8103;
        Tue,  7 Feb 2023 10:52:47 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id k28so9724334qve.5;
        Tue, 07 Feb 2023 10:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nqRoVqD3VOOrAVkOM3lGwJV6X/xZ3prSf3p+3tCe4H4=;
        b=i7cNcUSU4o7LvravnjUg2NRDGYvqi3CUowCoaT0qQbWPfBg0WVv6aHXFDEnoIhLM6t
         +uvQHA3j1JoxBp2v2SMFcKSD4WqWGpO6HjMiDInR50ls6hV+AC+jiGaQWud4rrzdopsK
         I7WvPqp9C+8t/ptfhPn2NjxWMbhQO6fQri5/ZkhPreryIQXCafzjd31WmHrmbxJVdUHU
         BCp/KLgndnmkjz5fYVgrh25qLG6jLYHiISFBETpz2r+gd+FAvxOQJb8nU9t4hvKim2T4
         BAkn2hJSC6Rq4Wwmi3Rtp+592dZ086HOnOaXO1wMQAISm9x9i4BaXZJgiZTPcNPFu1kN
         69vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqRoVqD3VOOrAVkOM3lGwJV6X/xZ3prSf3p+3tCe4H4=;
        b=8EFgCtGq8RCxs8tpjDW3rI2nU1O8+U1DhEpS032tvCxFqF/dLvcjPDe6dbNDExCbwp
         HZbrUEknDn6Urq0OFM7rgcPN+UM9ppI/hRMTSEbDGC4rZD6c+304VvNMZd5QLkgLBQH2
         lEQ9Jnb1cdlY5xSo3b2iDWdEWjemrOBFjvqsQ5zs4WoBe+Zj/sZlucsgIaZCJ0Nxfxff
         GhNmNtTXXrdvLChTdrMhFQsCko0YfgBFvCyZIH33Gu6RTh96DlNRimjr5BpmE3Fk1zBj
         2f9ab4HpvNnCLxOEHgHcB/Nw6snJWJUaBw3bSQURE6tLhFcElckui+RItfqlqoHt0S+D
         2ShA==
X-Gm-Message-State: AO0yUKV40h39HSU7rJ4csiWPxQAXACdPRDDsWZXt649bA6miYdzj6Ygb
        +p6jM5KrrZ84/fjwv7ZnTdU=
X-Google-Smtp-Source: AK7set/e8UEFpy2N4Y+o0cqf5y0FcBnZRxmWzXMGr0Swxyw2l8TFVbJ6tpnKFuqStvRJXrwCPiWndQ==
X-Received: by 2002:a05:6214:f6e:b0:56b:f210:8d5d with SMTP id iy14-20020a0562140f6e00b0056bf2108d5dmr7881641qvb.0.1675795966385;
        Tue, 07 Feb 2023 10:52:46 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l20-20020a37f514000000b0072835b8e4a8sm9902597qkk.75.2023.02.07.10.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:52:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0F85327C005A;
        Tue,  7 Feb 2023 13:52:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Feb 2023 13:52:45 -0500
X-ME-Sender: <xms:_J3iY6Gtt-Uj0j8wNP0lDklItq7l04qew7D5CS1Nc6G7yGLzW3bqtQ>
    <xme:_J3iY7Wvlcv03tp-Pm8BsiQ-IgmbE9O3axGEARQl3lGtEEqv9vEbDgfj0thzg787T
    rD1FQQboAHLX_Zzow>
X-ME-Received: <xmr:_J3iY0LG1BI8CiOovJKpM60NEHnZ3722HGRiCO78RsLQ6L-OS143b7_W_Co>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefg
    ieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_J3iY0Eic3QSJjNSX_xcZcEPeY6bmxJqCpEpSlAb6_S6z64zCaJAKw>
    <xmx:_J3iYwXA-zP7KtI8DGiPjTUXc8dl0e_R-TTmXu5n15JRYfA6r5E7KQ>
    <xmx:_J3iY3PcNyz1Sj0h6SjoNq1cXCcIhFUXbwRKxfwG-PZ63IBIgD8s2g>
    <xmx:_J3iYxWbyLPUZEuFIMj8nk_AJVLyN-ihtQat83_BX1V6iAs9zNqIkg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Feb 2023 13:52:43 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= 
        <sergio.collado@gmail.com>, Finn Behrens <fin@nyantec.com>
Subject: [PATCH v2 0/2] rust: sync: Arc: Implement Debug and Display
Date:   Tue,  7 Feb 2023 10:52:14 -0800
Message-Id: <20230207185216.1314638-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.1
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

previous version:

v1:	https://lore.kernel.org/rust-for-linux/20230201232244.212908-1-boqun.feng@gmail.com/	

Changes since v1:

*	Remove the refcount for Debug impl as per Peter and Greg.
*	Since the refcount_read() bits are removed, therefore squash all
	4 patches into one (I keep the Reviewed-by tags for anyone that
	gave to both patch #1 and patch #4 in v1). Thanks for everyone
	for the reviewing ;-)


I found that our Arc doesn't implement `Debug` or `Display` when I tried
to play with them, therefore add these implementation.

With these changes, I could get the following print with the sample code
in patch #2:

	[..] rust_print: 1
	[..] rust_print: "hello, world"
	[..] rust_print: [samples/rust/rust_print.rs:34] c = "hello, world"
	[..] rust_print: "hello, world"

Suggestions and comments are welcome!

Regards,
Boqun

-- 
2.39.1

