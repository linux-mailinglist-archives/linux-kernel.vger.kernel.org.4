Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543385B3AE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiIIOmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiIIOmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:42:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84F910B577
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:42:17 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id k80so2966292ybk.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6lhLlhxfOjgL1Bth9mcHIlbp3cpWG9g9ba2QTnmM87s=;
        b=MuhQoyzRTIr3sfU/R4tTPiPkiQTsnKI3UW/13xM3MteEEpI551whUSdSH412BQuKJK
         iU72F+nL8NcYglUCNx6A46k1JZ2tCh8GZQ1ISveNfPYBuaavJPBoAWmo1ehKLq6cH9wZ
         wb2YWKAyx+07CoDHzFr/sg5AiB2a6XAPL+TOICqjPRqtLm4vzMyf2gVLrtDOhCtpfEtG
         JoQ4Cm899e6YsN1HzPfKltu49VsE3ILRCdllduAZ/wJQ4i+39TIgqogMyjh9tytNTUUB
         lH122hho5jt8tc560VsFVoIxwTfpoOTo30C0ZFUiY0GN8hoI0/KdT1wB6ZH47KQ086+e
         sEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6lhLlhxfOjgL1Bth9mcHIlbp3cpWG9g9ba2QTnmM87s=;
        b=kYHswg7vy84zoqYudzueqrG4+YF9IG77BtLi/Q7nNXpyqIEHADzzFzLAq/fyoylWHz
         9AzLCQ3OSw5FKAUvekBli1jtUhHQ9nmQJ5EVUdc7GssQ4FGEY/CMfqNooEi1Ei/jMUzW
         bnEcwGV3jnYVB/FZCEoRKdQHN5eF+vkZlI5c+9OWg9IFz4j3k0wQRyY1m7xpsuo+muzI
         dYN9Y01sz+9bZyc8I/R+DnvYXI3zKCGa/qQTKCUhFPK57C1Ry8GICBShQIdOTOnnQlDB
         S7dfCWO252yKEdiBBmkLMdNf6B9QgVEEKcRA2u1nTRuNLPi8uDjf8CaWaDXZXhoz+40E
         fQ4g==
X-Gm-Message-State: ACgBeo3ghAO1ZT7D02LNV2qbZ4ggF6uWbuGK/2nRqsZmKmgR/gHZVpjU
        A373ieoMzZbQ9YpyNDVIB0Nc+lmtPmNerSeIfRQvQ/7Sw+E=
X-Google-Smtp-Source: AA6agR5cAeL4piPIDucGy46S2CIUgkur5XlmECL36enKIRCoOp/YALb/1m0B+JGkf0xpPdbqS3QgtCRqFWq0yopeAtg=
X-Received: by 2002:a5b:c92:0:b0:688:436c:b2b with SMTP id i18-20020a5b0c92000000b00688436c0b2bmr12028529ybq.436.1662734536565;
 Fri, 09 Sep 2022 07:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220909141338.19343-1-namcaov@gmail.com>
In-Reply-To: <20220909141338.19343-1-namcaov@gmail.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Fri, 9 Sep 2022 16:42:05 +0200
Message-ID: <CA+sZ8B-z7nRdJLhxeJ_tWSj_LBSwoFgtQja1-vDnBVdR=b0=DA@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6655: fix potential memory leak
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did not realize this initially, but this bug can cause more serious problem
than just a memory leak. In the case that kzalloc fails right from the
beginning with i=0; then in the while loop, "i" will wrap around and the code
will access priv->apTD0Rings[4294967295] which is obviously not good.

Best regards,
Nam
