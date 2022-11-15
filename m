Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6483362AD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiKOWDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiKOWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:02:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE762F66F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:02:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s12so23901348edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GcIrTj8VztBeFoy4k6qhtUBsqi2dQ47UyYJpB5EaTPo=;
        b=nftL9VuGbqz2wS8aoSGn3u7lKhkqTIh6Qw3ut+/2+mk6iuDylkuO4fKqsTWNWzmabb
         1+uO4j7fYObWyKAiKEKmBE6gzehSG2tyufgvwVYrmRAYLhOssRGJ9oA3QBbh9RyOLzlD
         D5fcH2cI5+DXyeI+BcwcFUebEsI1vJt1W0bEQaW9X71inPhHZi6DXA+kWLv8R2nH9LVA
         yCJcUwuUooshd1gvooIvbPMh2/lQOVvj9ve3fZmdH63tyY2mitEUq1BLVqJRK6kOV6ox
         eeo5WJFrUM+yQ2HFSuYk0Ulo2z+7GNylpGJhI/w5XIqx8FYdEGgPziqKHptGoWU+3dLY
         VcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcIrTj8VztBeFoy4k6qhtUBsqi2dQ47UyYJpB5EaTPo=;
        b=PYt2lztfazfZMxyEWA4AipWj5V+UTcWEYImlOVvxNv41IHNkwSGgU7NwfL8v3+Mty9
         j1hZ1Yn9qnBMZqgQCTdKkALjHDmRww7wufDgHQ30E7mOURUVEcCzwKAzNflB5WEloLcj
         a9SnlBsQm4X0tw7YCgYLW8RKRE9j8GQXOTal0XLM0TsiFaqtkjT/oH2V+Ww1dSazOZPF
         CcP6WhYbr3LcOvl7w3PcJHmZZwH0NGMNCiwv704MNIIVGKLnWG3KtFasADxBHlO0zMlS
         l41zS1sQNV8qyaJYQtsIc5ymSnA7BTOvYl6tGX6Ygmb80P6qqbOQ8i8HZ++9Ppvj5jcF
         oP3A==
X-Gm-Message-State: ANoB5pmBwnJ06tzdAI2w+/vsxtMwrD2Ix4Ur+KIAzbYaLwlJhsRjShrq
        7xgbrbPnP6GbO1/tNwuov4RaquO2vKN9d/TmPgSfyg==
X-Google-Smtp-Source: AA0mqf5SXfBI6T37ANtaU6IquIxC4j46qTnsreujvs83VOL05kbVxIsQj9U6F2D9Uv3/ulToJeZmoQ1bjTwySKzYq/0=
X-Received: by 2002:a50:fd8f:0:b0:461:46c7:310b with SMTP id
 o15-20020a50fd8f000000b0046146c7310bmr17315493edt.307.1668549769960; Tue, 15
 Nov 2022 14:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20221114202943.2389489-1-bmasney@redhat.com> <7420da17-d6d6-10e6-c87e-d3dc37d17ffb@linaro.org>
In-Reply-To: <7420da17-d6d6-10e6-c87e-d3dc37d17ffb@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Tue, 15 Nov 2022 16:02:38 -0600
Message-ID: <CAKXuJqgckbmikXwFi0g3P3Db5jvyst+xhQBcPoV7mA2XStVVzA@mail.gmail.com>
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Brian Masney <bmasney@redhat.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        psodagud@quicinc.com, quic_shazhuss@quicinc.com,
        quic_ppareek@quicinc.com, ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Others in the thread pointed to Thierry's patch, but on the Lenovo
Thinkpad X13s, that patch did *not* fix the issue, and with it
applied, the X13s still immediately reboots as soon as exiting EFI
services.  With this patch applied, the X13s does *not* reboot after
exiting EFI services, so thank you for this patch.

Tested-by: Steev Klimaszewski <steev@kali.org> #Lenovo Thinkpad X13s
