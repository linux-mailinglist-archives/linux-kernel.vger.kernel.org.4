Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0E626765
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiKLGRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiKLGRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:17:52 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FAE69DFF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:17:51 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id 13so17028351ejn.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SUnYP0kgCwUeXXgdI+TCo/SFpd9Gqab2nDh0GrqiI9M=;
        b=dyHEPHs6SNzXyDOK8z+wWVKaF9J6e9tgJFiGxZsPpbOQS968I7IflHjdtmnq7tWNSH
         DI4ooiQes6aAs2TzGiv0OVI++l2oRaOq0hxIdPew4ODz0EaHT4RYekbAT5I3XkFBNNHb
         w4JLVTZf6L/hLqWk7s+7Dwk1nVaRH6w304NUelNJzu44+PsPpzGms9wScqLknKvbF/XX
         QabHCxvbEQiK29syiwKxLUjUdbtP7SjqcosGDK6OvIF94rvVexNGQN9W2Un44XQhOjcz
         zbDlBDCOSo2igmhe4UxrjnSk81VXusuAmcKNQp/bMQkM+fvhSnVnw8k2YHKGyirRCEkV
         cMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUnYP0kgCwUeXXgdI+TCo/SFpd9Gqab2nDh0GrqiI9M=;
        b=nJ/AcQGtGG6PjgJ0FqtWwdqMINZ/4uuail0aOYwWsCpoKIjeVzfC7yLReBrlSG6MmG
         Zy1SG2rAMwQyOzUdp1t8hwC8cepAfgi2ghoZSW5SSScfvefdSOnwblFqzHvr0lRxKsgG
         7872PKqT0D/cruErHUzcyU7HRxiopa0z9dnnE97YHJ1CLrPZ4NKvhAoxh60x6KTMN/Gl
         Pp1RCwUfK7viIQhB3N0/oAqJwqyYNvo9+XSeon953AAw9QlRg1u4q8ZDB2NAdC22G4Dx
         Jx+tgRPlf9SFAszhqxkv2t9c4rGk6qE6TqZeXH6Md+uaHtqwMAeIaIVGz5sWpFa3UTHv
         DaZg==
X-Gm-Message-State: ANoB5pnv2GuPMBRIdllFh28bK+fpdxKUJqILes5ebAuPaqCiqa6N2w5b
        UASSqjl9Xq8yjyyjrEq+wk3rYrVTE7F5q1SijE0GjdVzaRA=
X-Google-Smtp-Source: AA0mqf44IpZ+OYYs55vt8San7g9aShuK4uTE0LW35HnYHqz0Jgsm8v/BcwCgNFVWN7gjpbBR6k+SgYRC+0zgFYM17VA=
X-Received: by 2002:a17:906:6843:b0:7ae:65e4:7204 with SMTP id
 a3-20020a170906684300b007ae65e47204mr4133849ejs.579.1668233869904; Fri, 11
 Nov 2022 22:17:49 -0800 (PST)
MIME-Version: 1.0
From:   A <amit234234234234@gmail.com>
Date:   Sat, 12 Nov 2022 11:47:39 +0530
Message-ID: <CAOM0=dbwNs1XcnD0i+SrC1S-SNFEGXM5G8QrVCqAxaz=YkAEFg@mail.gmail.com>
Subject: Setting variable NULL after freeing it.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am writing a linux kernel driver for a new device.

Is it a good practice to set variable NULL after freeing it?

Something like this -

kfree(x);
x = NULL;

Please let me know.

Amit
