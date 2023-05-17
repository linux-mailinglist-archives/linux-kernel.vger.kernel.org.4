Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6B706C96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjEQPZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjEQPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:24:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF3C1B7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:24:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5618c444144so13339987b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684337092; x=1686929092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnexIi+TxreyDAUHb0Mjgnif4bQcARXMQxbarvvFgbo=;
        b=gG4a7BCw+xjRwraoHmaBphV3vfExPEQ86+HyU0GYwfzhKsWc2w+aGZ/8ej8LAzAjWK
         CDSPmfeH6MDTF1LKD287EIeWAQ5+pTW2cxmaDCPigOWU5O1jAvfSlnVdv98eaRjaWNQD
         TOXjnnntFteMrAjy1+Fn85Wk1R6YhbFF+b4hZQg/eTK644J7q6XiqWHnUpD7RVyF3Ur/
         Vh0LhC2I+p6qe0yXBuSsDMm/JYa703lProjpA88/yIUzQIJdYMjJie78H+WpbN/wfdeS
         0xL6qXLE3RqHAlmRNPQsHiRwyhJm03dErkOH9cr1R1FCRPHadCHVT6+7aieG4A3ZLl1/
         //1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337092; x=1686929092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnexIi+TxreyDAUHb0Mjgnif4bQcARXMQxbarvvFgbo=;
        b=dC0ote3tSHM358XupmmJbVbE/c6Ia92yrmvbMr8CneANO92q25m26b4u8PExPtjAAI
         PfSUayqwm/DDBcxja1Jw3pQLCgr4GYC4mo1AuJhATVZquHe5tlqVbL/608/wFdloQAeX
         OWhiDKEd77VBeAi3RcuejPjn/ymztN8d3kR62P7letF9mv/3eiaFZQ+MFvvBCiyIbMco
         Ic3vtJ2OzD1vsLeIwye5zXpj8Esxk4JxptLQ+1bb0XsTHX7E/7Ls1hWi+JKisado4U+G
         q6Ef+Gsi+WBV+xKl64Xtq0rGp9eXQCDrIFDM7thxXVz7pmaL8SIrkTuiAim4YUvye7Ie
         kR2A==
X-Gm-Message-State: AC+VfDxUl+Lpjxd0fRfbo+e0VA8XITS6aJIdcKPPgMuBIPigq8EXCCZt
        ZH6sC6EmCVzdacP10q5rVLyuHmo3EP1B
X-Google-Smtp-Source: ACHHUZ7s5M1QVIyLYOa3GiqYHDv+mM9WIMI2SIqbgMo9Z9/2tUWOLUCr0avkzeishPTE24wRjCmgZy/RfrYV
X-Received: from tetrad.chi.corp.google.com ([2620:15c:2:a:3c32:ed06:dc65:d66f])
 (user=jwylder job=sendgmr) by 2002:a81:af4b:0:b0:561:8e86:9818 with SMTP id
 x11-20020a81af4b000000b005618e869818mr3494968ywj.7.1684337092449; Wed, 17 May
 2023 08:24:52 -0700 (PDT)
Date:   Wed, 17 May 2023 10:20:10 -0500
In-Reply-To: <ZGQqzlU7XPF+rS8c@finisterre.sirena.org.uk>
Mime-Version: 1.0
References: <ZGQqzlU7XPF+rS8c@finisterre.sirena.org.uk>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517152444.3690870-1-jwylder@google.com>
Subject: regmap: Account for register length when chunking
From:   Jim Wylder <jwylder@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I didn't intend to ignore your point about pad_bytes.  I had
misread the second half of the sentences as being the result of the
first half - rather than as an additional correction needed.

Thanks for the feedback.  


