Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1E66E7165
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjDSDDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjDSDDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:03:05 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005E1868F;
        Tue, 18 Apr 2023 20:02:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38c0a331d3cso918553b6e.1;
        Tue, 18 Apr 2023 20:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681873371; x=1684465371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy2us3ZF8Tj2uMWYJJfvUD27ubXE3+0nUE1gRG9Duwk=;
        b=k/vAgxx03RaApkIGw+hA6V35gOL56X2LGZ0CU09W/ENxcytiBPHMnZbvII0+LGyMrZ
         M47ldLvvPyLrrBs+s/xlM4X6KHXHUnjNuvpcHI0besLf9fatk9EqJnZimdG+3h4Z60pL
         q3fwAF8j4i9oYyu4IDGjybA9416G9JfwToAfoNHfKicxpqjYAfBTHzvK6zPm2jguSGmb
         n5W6UrLfYvnm6ZkgOICc4UbNKWxR8jwuVEtryMoxbNcAylxDP1HbvbrDVZRp/BCyppmn
         rBX+PT+TedqXAguPXZHZP3h1NdX3JDsVsc+CJrD/PhVYkQLpxjIoIhAZuRoh2pz9yMFJ
         f/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681873371; x=1684465371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy2us3ZF8Tj2uMWYJJfvUD27ubXE3+0nUE1gRG9Duwk=;
        b=bdyTBkwn/bY3FYTe3gKPJamQugDS4ZoZ8EnaujM947FMUUIdRV35Pz5gnwU8bMTiCG
         AraVH+Izo8k7FbyyEDJ9GtkYgFEee2VspEtStWGC6OvmlV1YP25wBhTA6g6i0eeKmCPK
         T+M9C5yKr31ieaeaUk3NiLKTPmI6ov0b/FxdB0ejQ2sesKcbtoj9uYayd3qUfBuO4H/f
         /998dDj5z7cS4Oyqka6yQnwEN4rNGuiCJ4vqyx2IgaYzPQ4NJ/I4UPxXFpO3LukO/jZu
         FWsK1EJckY0TR3hrqZke0rCg3uUhZniNxQVayMY0P7NaqWYCs03H62sShwl4VEcxkn07
         Z7TA==
X-Gm-Message-State: AAQBX9fl1FDz1YPaIUtpo++uNZkSWV7A5wH74BgXHLgbPfIh97fY+n1a
        0omWsMfSHg7QssOkv+FxOLUGcXMkg34=
X-Google-Smtp-Source: AKy350Y6+wITuOdfOsSOOKiQoCcAoM5PO9PRAiLdSl7AkNOZ2vuecpem+Nn85c8JloA5j/LWfiSYTg==
X-Received: by 2002:a05:6808:f86:b0:38d:e2b0:d5ea with SMTP id o6-20020a0568080f8600b0038de2b0d5eamr2209793oiw.44.1681873370896;
        Tue, 18 Apr 2023 20:02:50 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id bi9-20020a056808188900b00387160bcd46sm6498859oib.46.2023.04.18.20.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:02:50 -0700 (PDT)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        gyakovlev@gentoo.org, jan.steffens@gmail.com, jistone@redhat.com,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        william.brown@suse.com
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.68.2
Date:   Wed, 19 Apr 2023 00:02:43 -0300
Message-Id: <20230419030243.540348-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418214347.324156-4-ojeda@kernel.org>
References: <20230418214347.324156-4-ojeda@kernel.org>
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

On 4/18/23 18:43, Miguel Ojeda wrote:
> [...]

Kinda bunch to review, although may I ask if each time the `alloc`
crate is updated is worth to mention the changes upon it [1], can be
skipped otherwise.

Link: https://github.com/rust-lang/rust/commits/master/library/alloc [1]

Reviewed-By: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
