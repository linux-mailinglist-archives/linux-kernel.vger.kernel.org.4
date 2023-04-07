Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99506DAC39
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbjDGL3O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Apr 2023 07:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjDGL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:29:10 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA93A5E8;
        Fri,  7 Apr 2023 04:28:49 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso4297781a12.1;
        Fri, 07 Apr 2023 04:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680866917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=877eU4ZABdImKgz+6f+4rhLkh0VZx+uXGk1JZRJ2xMM=;
        b=Nh4LFBvowsfH27oCrGaml5BCCavOJR+xTC3vTCWR//2xDoD//qmxO9a4XqVSTVFWqt
         g/dl+V3TAkIa+EJMba8WT5MiwaH+TmAeCAriK9Pxrqq9Gy5txDPxmIcXxlMUwFAvJHjM
         VVGahWQB7nWPU6/RaMdxoMKA+s8oO4jve/cQ/L5TaLet7p30XrlFmPJIkYg6e9DqhTcv
         nYKR4sD4foooNnCRN9OzCY4yDf+PFDfqifwttKTyEGS0LiZYio828LVowP7yDc3HFba+
         rdPUVnav4zRf4SqVVGGbRTb4kbuNLP8K3Opef0p8N1vrkDupYrSaJ9AkKgvFXFKJWYOU
         qYsw==
X-Gm-Message-State: AAQBX9dywZtrBrb2wZfs5wWn53xy4lFAeO8v1lKsrB3dNDsTmxAqRzXn
        lW1MGe8bMPuk3Ug2byAS7XuRG995F4+Gw0lZVfM=
X-Google-Smtp-Source: AKy350bfBOd6xqzWl8iSO9i3cFeugti3HfJT5ir88UUP4c3CU6XW7zwLUPASgI37QYX9oTFxhvWYqm/wqaFJCUArLBM=
X-Received: by 2002:a50:cd02:0:b0:4fa:71a2:982b with SMTP id
 z2-20020a50cd02000000b004fa71a2982bmr853718edi.0.1680866916681; Fri, 07 Apr
 2023 04:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230325221935.3943-1-zeming@nfschina.com>
In-Reply-To: <20230325221935.3943-1-zeming@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Apr 2023 13:28:25 +0200
Message-ID: <CAJZ5v0gOrBep-gm-7npdkKSuw=CGhVOj3Se1orW=y1TLnzTE+w@mail.gmail.com>
Subject: Re: [PATCH] base: power: main: remove unnecessary (void*) conversions
To:     Li zeming <zeming@nfschina.com>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 6:48 AM Li zeming <zeming@nfschina.com> wrote:
>
> Pointer variables of void * type do not require type cast.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  drivers/base/power/main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index c50139207794..f85f3515c258 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -679,7 +679,7 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
>
>  static void async_resume_noirq(void *data, async_cookie_t cookie)
>  {
> -       struct device *dev = (struct device *)data;
> +       struct device *dev = data;
>         int error;
>
>         error = device_resume_noirq(dev, pm_transition, true);
> @@ -816,7 +816,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
>
>  static void async_resume_early(void *data, async_cookie_t cookie)
>  {
> -       struct device *dev = (struct device *)data;
> +       struct device *dev = data;
>         int error;
>
>         error = device_resume_early(dev, pm_transition, true);
> @@ -980,7 +980,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
>
>  static void async_resume(void *data, async_cookie_t cookie)
>  {
> -       struct device *dev = (struct device *)data;
> +       struct device *dev = data;
>         int error;
>
>         error = device_resume(dev, pm_transition, true);
> @@ -1269,7 +1269,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>
>  static void async_suspend_noirq(void *data, async_cookie_t cookie)
>  {
> -       struct device *dev = (struct device *)data;
> +       struct device *dev = data;
>         int error;
>
>         error = __device_suspend_noirq(dev, pm_transition, true);
> @@ -1450,7 +1450,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>
>  static void async_suspend_late(void *data, async_cookie_t cookie)
>  {
> -       struct device *dev = (struct device *)data;
> +       struct device *dev = data;
>         int error;
>
>         error = __device_suspend_late(dev, pm_transition, true);
> @@ -1727,7 +1727,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>
>  static void async_suspend(void *data, async_cookie_t cookie)
>  {
> -       struct device *dev = (struct device *)data;
> +       struct device *dev = data;
>         int error;
>
>         error = __device_suspend(dev, pm_transition, true);
> --

Applied as 6.4 material with some edits in the subject and changelog, thanks!
