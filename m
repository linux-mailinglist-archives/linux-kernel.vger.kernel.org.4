Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAD76C8E63
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCYNJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCYNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:09:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761FC126F8;
        Sat, 25 Mar 2023 06:09:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eh3so18053503edb.11;
        Sat, 25 Mar 2023 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679749784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BivoLDf3VVsPCNHpqkq3yz6m8MDZznemKX2EBNEZN08=;
        b=JzRDixDW3uR/Ix337Eclo3haZk+PznJW8nHzW5WJUNXRm6KRixGO7jKbBqVbqlGFhj
         bEbIw2DuKtOWxwf0oL+iRtWdKqApXAeeF1YwfOkKgtJHu/9WTTL74Vfa24X7LCSirV+A
         VBm8LtvCwAGIa2zZt9g89FvJfGJ87no4ryc8eHxzDPZ/vNqaB8BiotjZMR/dWJa5fkC+
         CEcmo+4ukDpxB3HbcuwDzpn4qStoDLqmetmYLQL1mLdKTHzu9JKHOr4HzygXLtHDl4xR
         Vs6rIGvjlZGE29L1dShqw0opIjvPcbuaQ5+WR/DFyIVkjeMXbQ41mCoTA/2SuDswJRxO
         OWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679749784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BivoLDf3VVsPCNHpqkq3yz6m8MDZznemKX2EBNEZN08=;
        b=EbEOTfoZWip1qZxCY68dagffYFAxw2TAtGahlyqpZLgEriH3vSdF5qiheoi6N9QuiY
         rht+QWXdv56tvIJqY4J7DFu+CvWgG5dDiJ6VhPdYdzGzZhUXlIX2xVNTXijHXqcqRsRC
         8P42vOg1w6oRHnh+b9pZxLs+VS9XtB7xmMI0aulpqop6PJL0Sdzkpx/UZojV2/jJr5pk
         mW67ngXjJAkAyYT5l/BvLykt11STAhne4cmPSFxT7LE6Y7o3ayImTYcvGYdRqRAxdEkv
         xBKXVdXunmWYz553QY8/x+779B21XYKl1mbHWrXiM+VwqomU0239YhAOSia1j2xSaLun
         r9SQ==
X-Gm-Message-State: AAQBX9eFOIebR86M/d5aoz+HERZo9Snv8DlIAsAMYsTHbnbQSkKWoUS+
        3gHK7ELzvNSUOGBqEd/DAB89zgouOJEWhKfUF3I=
X-Google-Smtp-Source: AKy350b73vFj+pZqqUFZhR/pREKA9FiHjczT2L2Xv6G8L8igOFUG8aqx2VJ1hJgYhHMVBooRxexmFVqke1rOYDNcQow=
X-Received: by 2002:a50:8acf:0:b0:502:3a4b:1f1a with SMTP id
 k15-20020a508acf000000b005023a4b1f1amr423545edk.4.1679749783823; Sat, 25 Mar
 2023 06:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <202303241020110014476@zte.com.cn>
In-Reply-To: <202303241020110014476@zte.com.cn>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 25 Mar 2023 14:09:33 +0100
Message-ID: <CAFBinCBCdW5Nt+cm_1E-6gG1UNv7mnnDYxQRGae_UtCigt0+uA@mail.gmail.com>
Subject: Re: [PATCH] thermal: amlogic: Use dev_err_probe()
To:     ye.xingchen@zte.com.cn
Cc:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 3:20=E2=80=AFAM <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with dev_err_probe() to simplify the code.
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
