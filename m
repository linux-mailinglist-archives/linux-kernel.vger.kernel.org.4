Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1F6E37B9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDPL2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDPL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:28:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9353A1A2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:28:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2efeb5f8759so452606f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681644520; x=1684236520;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZT2W9jzeq3ab16dmG/smJ3JspsurtCTZoJG6Q9bZcFQ=;
        b=TTQNWU9eNvqN1vR5d/IzW6Ok4J3tcTgn/Cl6GQDlpX6D8hMrWr89Zhv2E+7TKgz9Ox
         EbZi9up5O+r8G2uBG3uvzC3fuDuggD3FajCi6PuDZHSaMQsFfLcu139sk17hMZE5wFZh
         wJmdra/iWWE5A/6GiBoDWawK/0BMOjKk4uiZYxSBHiHNA9VcjdVevWkXK9C5CRWvAFl9
         +b0kJESh42UY5qYnQHJb4Ufv1z4H+4vj+iBUpVX2Df7QBJWVElYpj6MPgrONukaj2Nzv
         HRO7f4McuWYxrpgVhIGB6PPSSx0F7zuwwhId0WNH+RzM8ZfDzhJJi84kbkIcxf/zDMDF
         52ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681644520; x=1684236520;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT2W9jzeq3ab16dmG/smJ3JspsurtCTZoJG6Q9bZcFQ=;
        b=CfR0xWCsFdJbtOnIN1r8vChDCSBOVObAVoJzPxhgerohkJKwsKRr4Ny2nxLb/DLCVc
         VEdu7qWGCTAH42C+9W9fSOFM2yeU3dJWCfhBgxv1SzgCccuhUhA4MVCPMgbyAXS/P2gK
         mm401OTa/4zBO8xxMNwaD9pq8UByMR612M/J1Nowx+yp0I/qc+GzivtQSHb/F7ZsdbDN
         kKHTfRzJRCxIg7xMkv7AIURvyK6jckcW7o4HAJnSx8xVRK6gp7HH3/qEdgS8QVvN09S1
         ME85bDUxUbD4pagEy0E+8ElHDoDJ4EJilMRG5LZOFw8MYveOAaxHkUfpM76nFEAGXcw/
         BA/w==
X-Gm-Message-State: AAQBX9eWEzB5O8sW/Nauk3HWOAp2Af1sETr0y8LK2CBZKNZgafO8fDWP
        4DecRxa/23iShUpZjzoV2S2lHXdBOnc=
X-Google-Smtp-Source: AKy350bF1MWjcUSDH1HzIwsBLbwfZGIFo4Ib/uOQIldvQCcCLrVXmaYZmq670NeYJeB+N0L4j7SGJg==
X-Received: by 2002:adf:fecd:0:b0:2ee:da1c:381a with SMTP id q13-20020adffecd000000b002eeda1c381amr3584291wrs.69.1681644520020;
        Sun, 16 Apr 2023 04:28:40 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:2f8:26e0:c056:12a6:fd8b:8723])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b003f09d7b6e20sm9068231wmc.2.2023.04.16.04.28.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2023 04:28:39 -0700 (PDT)
From:   Daniel Diaz <didou.diaz@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Possible dual license for rbtree ?
Date:   Sun, 16 Apr 2023 13:28:28 +0200
References: <180269da-a7a3-97be-4e8e-c8b82e33d430@gmail.com>
To:     linux-kernel@vger.kernel.org
In-Reply-To: <180269da-a7a3-97be-4e8e-c8b82e33d430@gmail.com>
Message-Id: <7942D912-11CC-4F1E-9088-36031BB52118@gmail.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This comes down to modyfy the SPDX descriptions of lib/rbtree.c and =
include/rbtree.h, include/rbtree_augmented.h, include/rbtree_types.h as =
follows:

I juste realized there were 2 versions of rbtree (not dispatched exactly =
in same header files). The rbtree version that could be made more widely =
usable by a licence extension is in the tools directory and the =
associated source files are: tools/lib/rbtree.c, =
tools/include/linux/rbtree.h and tools/include/linux/rbtree_augmented.h.

Daniel

