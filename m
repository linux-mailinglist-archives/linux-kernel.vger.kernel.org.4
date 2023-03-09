Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB256B3230
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCIXp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCIXpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:45:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76BAFAECF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:45:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so7987972pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678405523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joK1iLs9YJ7HYS6kSzl2rZbt/PuSCafHcz/xrLe7jGo=;
        b=bJFC/lAxRaHk+mJqFSplHzH565OHscdq/bY/9CaWiQOg8ijsx/QWt+KjSnlFrcR+xR
         4I1MJqqwVstjWukbZY6XdRsy9bNQSN/vXnzu/GEMWzZTYVGIw135HxxyK2++JSB1jCwy
         bP7vzNceDo79Gggr+2xGhQQcleXlWrDTzDQUlFJMW8ZQE1RtzafjjlEqdvydZ4fz8OTD
         Y6VnRI+sJpkqAnzSvB0URvwz+nejVbgHzuJuAT+kACmJuxKTloH6ahZu62YHu56dSLtK
         pQvzd09T9tcOEZKDsBrx1zvXbF56C2jQ+8HzE0y00ywXkIa00ErlFPhBOm7+RwTIXAz6
         4XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joK1iLs9YJ7HYS6kSzl2rZbt/PuSCafHcz/xrLe7jGo=;
        b=e6cd/ugKfJc1xraQvj5GO599iOLaSX0Rif38vEfMoyN2VrG/r/h6kPXHNGtCuJdL4g
         r2i0mJk43u9RkF5UQeOQ+rlMjIija8ngREq1ZspqUUqhQQDVEaXBkEpIc7WnbpgpObEo
         2EQKXuy7WOXfDyQAdiw348vzncr4Lo3GILrC+JQDyQG4LZDKbBzjvgl0e6iDYkXdUwSb
         oWO30PMfc1JgTVnMf0y8akPwnuyqju39KlnQVPzcH7YxZ43lE8+kzMpccsb6a3vinLwG
         irwiJHgj6H4w/sulyWlgYbd33oyRZPb3s77ZeAk8xQA+TABcBU3uQdpht6pY96ankpa4
         JlYw==
X-Gm-Message-State: AO0yUKXYdRUGUljuVMXD/4Y0JvuZDWFWV5eC+S/RO8rhyAbKd9YSQeg1
        eNt+c9Kml809uMiD56OeJ18Lany3LwBxHAbUMeWt
X-Google-Smtp-Source: AK7set9RqqZSFE77wMatvCcE/t3Pq4nptu8SVgLeYYg9Y3Xs8cDwkREIi1LMWiYTY9uI7Ha62QlVV3bMgcEiTsZhy9c=
X-Received: by 2002:a17:903:485:b0:19a:f22b:31d4 with SMTP id
 jj5-20020a170903048500b0019af22b31d4mr9142241plb.7.1678405523115; Thu, 09 Mar
 2023 15:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com> <20230309085433.1810314-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230309085433.1810314-4-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Mar 2023 18:45:12 -0500
Message-ID: <CAHC9VhSuXxpS_eae0gi4zGFYWEXrxFZD7joaV-qhNmmvf_tcMg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] security: Remove integrity from the LSM list in Kconfig
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 3:55=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Remove 'integrity' from the list of LSMs in Kconfig, as it is no longer
> necessary. Since the recent change (set order to LSM_ORDER_LAST), the
> 'integrity' LSM is always enabled.

See my comment in 1/3 about "always enabled".

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

--=20
paul-moore.com
