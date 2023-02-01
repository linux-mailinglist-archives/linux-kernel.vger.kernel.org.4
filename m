Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FB7686E58
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBASqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBASqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:46:34 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A0759F7;
        Wed,  1 Feb 2023 10:46:32 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h24so9933306qtr.0;
        Wed, 01 Feb 2023 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OeTWkDqjypR+OgsPjgWaQEZKoQPFobObyrEFRJd45t4=;
        b=YnesV+QGJCO+tYOBKNXn3KHglCGHnc49xzwu0vFwlC8zIGQl+PPHTT5Ilepth4J5Ax
         +/9T3Xw+w/dH+/xCr1IiMBV2+fHHCVYZBZqiKfQ8xHG2MaVRIWaQwGv5F51goFcPYSi7
         IpdmZOmGpIAcDXer+x1mKdf2w0eCk0ewVWRBBWy6TlhhftF3OBgvc7WGsMBc2ciDtzL9
         S1R4zT2ZE8aRqXBTjIODcAo9/njL6j7KuEB9SwQD4+S/9Q76fe8wod5brJ3YYrH00pjm
         40Ud4ChmQo6JuWUtE67+8OGPMzdaid9Y71LqSfvpDzRo+eBXTPGVrfPt1nOMxaHzI/gU
         +1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OeTWkDqjypR+OgsPjgWaQEZKoQPFobObyrEFRJd45t4=;
        b=oMzArw/vnwaPRuMIrPDChWN2FaEUJDfZOwIxbdgbSaKXLU4aBtQ/1syC3050fGo7pK
         6vVBDgAzn+EynnW/NrCXaY4yINpgnaI7cWUlqFqdsFAPI3GzHdM+AIdQkFxmhDqTZedK
         6tmTkRjU0Bpb3s/+g6o7A6rbAb7PklajVrhzR8StZBfs4qMi6s+F5Z8h5Z2LJ/83R9lz
         Jf5ycL8xTv3tZjiz5Ac31/ZeeN8lWdgyipsvF9rL8I+YfAAL/kECL8upcZ18YW2JKeOt
         WE2lh+giuXIeg0wyEgASABhzFDYx3lwXuyKZ4R7fa2Dby92/KN04N7RljfhU/yTWCEjp
         7AfQ==
X-Gm-Message-State: AO0yUKV49PLvDa4i18h1BEH1KMBVViuYeIaddlHajOW3lO1GskYOi2XG
        FUHjUByzI0hX91N241QqVMw=
X-Google-Smtp-Source: AK7set9HX2Q4wrbU8BP/0tQHxvhf62Ikvv1UPtBUxpQtRj4bOEmhr+SFO2iLflQ5YuViwC4EmaM3Og==
X-Received: by 2002:a05:622a:1815:b0:3b8:525f:f0a7 with SMTP id t21-20020a05622a181500b003b8525ff0a7mr6775627qtc.56.1675277191167;
        Wed, 01 Feb 2023 10:46:31 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a03cd00b0072771acaf09sm2997426qkm.126.2023.02.01.10.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:46:30 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id E370C27C0054;
        Wed,  1 Feb 2023 13:46:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 01 Feb 2023 13:46:29 -0500
X-ME-Sender: <xms:hbPaY6dGf4sZvAW5S1BHbcKgaQFkU9zJlakq0w3M9bQSFf9SL5_fug>
    <xme:hbPaY0M7lfoZLhQ5_l5SpEdc3YjLkug0c2RllYMBgmOMFxyJ0MO_afFdbpMgZZBwf
    hC52oUHdFE57O3p4A>
X-ME-Received: <xmr:hbPaY7jF7HcZpqpN1_kr7T_0fZsHBZqnuo1BvPt9VWWUW99gKPVptbtWCN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptedvfffhgfdvvedutdefjefhvdevjeehleeihfeiieevffejgfetfffh
    jeevgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpd
    iiuhhlihhptghhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhm
    rghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:hbPaY3_r9uN2GMNwVmNSVIKapqrq8XRNNZGIR-XXnRS_csPzYUTzvw>
    <xmx:hbPaY2sjDl-GwVWSAI62aWZSOpELf08QsGuHBI3bNzXz0uQcwHAc6g>
    <xmx:hbPaY-HSYR45EwnZCYjS3OxAoUeEw3q7oEBZjJvgXwWaIK0mWEtgbA>
    <xmx:hbPaYz8cILfOq7-vAMYGIUpMiuxcG2t1U4f6cK0LGRyDJmm2IqWqmg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 13:46:28 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] rust: MAINTAINERS: Add the zulip link
Date:   Wed,  1 Feb 2023 10:45:21 -0800
Message-Id: <20230201184525.272909-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <CANiq72mGk72tvLx+uH-puXZ=MvAA9dzNVqTXYmPq2iadwYuyWA@mail.gmail.com>
References: <CANiq72mGk72tvLx+uH-puXZ=MvAA9dzNVqTXYmPq2iadwYuyWA@mail.gmail.com>
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

Zulip organization "rust-for-linux" was created 2 years ago[1] and has
proven to be a great place for Rust related discussion, therefore
add the information in MAINTAINERS file so that newcomers have more
options to find guide and help.

Link: https://lore.kernel.org/rust-for-linux/CANiq72=xVaMQkgCA9rspjV8bhWDGqAn4x78B0_4U1WBJYj1PiA@mail.gmail.com/ [1]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v2 -> v3:

	*	Commit message improvement per Miguel.
	*	Reorder the line after "B:" as suggested by Miguel.

v1 -> v2:

	* 	As suggested by Greg KH, add commit message.
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd..80fc5f050f28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18222,6 +18222,7 @@ L:	rust-for-linux@vger.kernel.org
 S:	Supported
 W:	https://github.com/Rust-for-Linux/linux
 B:	https://github.com/Rust-for-Linux/linux/issues
+C:	zulip://rust-for-linux.zulipchat.com
 T:	git https://github.com/Rust-for-Linux/linux.git rust-next
 F:	Documentation/rust/
 F:	rust/
-- 
2.39.1

