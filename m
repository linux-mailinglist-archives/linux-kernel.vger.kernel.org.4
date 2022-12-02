Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8398D63FF93
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiLBExW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLBExV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:53:21 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F19837C6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:53:20 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id o24so1811409vkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 20:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo/Jzmj97699FgsVRo9A86tN5cGByg6vtV/IG9s+9pg=;
        b=dCXDQdIIYmKKBL8B+e5zAeamhBp/z/6Kx8FkljUP1lVX3OoYJ+mO0JpwQXrre1qPBl
         cljb4UmEcD+6a58p+AyRqoMZzlIYrg6s5yCersKax9MJOEaYPA2IrfkN0iD0RGf8oOFK
         ZydwDyZIy3cNDaoFqzsDu1aPyJRI1Low86e94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mo/Jzmj97699FgsVRo9A86tN5cGByg6vtV/IG9s+9pg=;
        b=XBZCVbmjyIYByzAFUqIADaQlSPyTTwQLZHrYZUXzpSV4lksiGNrWtQWB01/GMY7Ezf
         FYhPfdMSKWyefAqURm0hhOuZnK9+4AnCbPVeXJyVOVIn2Hs3caHpSXTTE80BQMAguwVx
         /efPuyBk4+ZuBkiYZ47R9kDFeTTMrBLbkmKwdQ2meePTSWOAM7z6ubSL8zc++vEepdKF
         SX1JFCPqPCijxNfpyN++N3w90Waj1Ve9ajrGypMTLjN+CMOR6idfjVsj5oM9lf0CUI7d
         393OcVyj65O81Qb4asx1Ggrgaf1RQEMqE56KkYAGzIR7o/pyH+jsLG8S6VkZMz49byJt
         fTKw==
X-Gm-Message-State: ANoB5pnf0kfVnylQFJaiokmUyX6JaTwVk7OuiZASNemyV1P062Cd3fO/
        f6IpQ8hAwZ8LOQuaLNgPRd8/s071G3XiGLKNMz0XO9Eq2uZX6jmW
X-Google-Smtp-Source: AA0mqf70jBsrJPWXLS/68AGUc508wiotE9Jhx8V/d9D4GSUqZHrVHwjsa4fIBNevkAUjSD378eCDts+iU6XdDanz5b4=
X-Received: by 2002:a05:6122:c77:b0:3bd:4b97:a4fa with SMTP id
 i55-20020a0561220c7700b003bd4b97a4famr2786758vkr.7.1669956799411; Thu, 01 Dec
 2022 20:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <CACeCKacHWPVv=sDo5-VjpckvvFw6YmqvXCyLqzgbXBmG080mmw@mail.gmail.com> <CACeCKafaZNqtKb8=thALgX4yaVTqsPcGQsHEKUZEVB0XWaNMKg@mail.gmail.com>
In-Reply-To: <CACeCKafaZNqtKb8=thALgX4yaVTqsPcGQsHEKUZEVB0XWaNMKg@mail.gmail.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Thu, 1 Dec 2022 21:53:08 -0700
Message-ID: <CANg-bXAO59iDV-KNzCk=o6jTtPRRGho5an=mp4Y5jcZsmd33Gw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] platform/chrome: cros_ec_uart: Add cros-ec-uart
 transport layer
To:     Prashant Malani <pmalani@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +               /* Received bytes are more the allocated buffer*/
> +               ec_uart->response.error = -EMSGSIZE;
> +
> +               /* Wake the calling thread */
> +               wake_up_interruptible(&ec_uart->response.wait_queue);

I believe the "received" conditional variable should be set before calling
wake_up_interruptible. Otherwise the calling thread will not be (immediately)
awakened as the condition is still false. Currently, the calling thread will
wait until it times out in this case.
