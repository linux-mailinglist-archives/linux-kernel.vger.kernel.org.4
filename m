Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01673DFEC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFZM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFZM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:59:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB5910A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:59:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fa99742be2so7767575e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687784370; x=1690376370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=apk70vZy4KhYcnG84Q1wffo81Dl8DaLTVZRWL3wj6Xs=;
        b=caap5YVaJxmKP2ba+RBHLW3aV7Xw/RxMUuOzSGrHC3hoeFYNisi3znUAm9NeP95/un
         2p/He1Ved0EDYRQE7KVoMZEMTK6ptlZC3iWFQBrwBLAGEf9NqqqV8Q8hvDOr3rup8TJd
         jpmW46Au0Vsoo+lP/AIlkg/Mj9kpzvgfVsJJ8IdDGDJyDzcrZo9aInKMreHWCF17/UqE
         Pgm/pKnQJs8OtBpkx3mmYmto3MDF2SW0tuoAzgz8iju/WEjOyZ5C9XwMkUajztQfBSBG
         j9N29fLIXxoRolJQx5wv5LbMT4x1ApRFBJvdc2IW4hpO72Vm4s9gvvN2mOKWkRypjne2
         9EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687784370; x=1690376370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apk70vZy4KhYcnG84Q1wffo81Dl8DaLTVZRWL3wj6Xs=;
        b=RhZmag43LgQ/VBi+t8eM5O0z+Q/fNgVHaqQ+U/WCLFErff1hUWcGBdT/tRGyf7zVXU
         qLCiO9j7ayh/o+uIiFO/28ceomVLaxfjFGlI/4FVJLI9KH+70ng/9a6m8XLn1LH57Wac
         /5F7kv8g8dhTrgG8S8xtPyK/3gKnUSvUuXmE5aanlAfKOhfGfUliZgg1lbnZtOSLkC2F
         Tx7CEbFyCXcrNXLZ0K8PBoIYQ2lf2cN+5zEinpQKhKgkScbZvMyqoOGtzNhLyUUHSnn4
         GJU8LjVUTqv7zHozS97CvgJmuDTmIt5WM/Cur+GzBVsOtx4jKHhGCSjj9N7WWOoC0C8g
         rJZA==
X-Gm-Message-State: AC+VfDxt2CGUgZn052qrsTiHmAZjtmpXk2mJHuXj9WXjxtgwP2Vp/eOp
        dpuvuowl7Vdl5DmArkTXZZR85w==
X-Google-Smtp-Source: ACHHUZ6cBlNtxq75cN4Re6BcQmPh/298izmROOMzkk3aoy5z+JpobqagrTiu+DwsCmdHdbox+wHzaQ==
X-Received: by 2002:a05:600c:2942:b0:3f8:efc5:3382 with SMTP id n2-20020a05600c294200b003f8efc53382mr24739064wmd.31.1687784370379;
        Mon, 26 Jun 2023 05:59:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6e85000000b003063a92bbf5sm7386241wrz.70.2023.06.26.05.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:59:28 -0700 (PDT)
Date:   Mon, 26 Jun 2023 15:59:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>, dm-devel@redhat.com,
        kernel-janitors@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dm ioctl: Allow userspace to provide expected
 diskseq
Message-ID: <e42e8115-6f75-447e-9955-ca4ad43ed406@kadam.mountain>
References: <20230624230950.2272-3-demi@invisiblethingslab.com>
 <3241078c-2318-fe1b-33cc-7c33db71b1a6@web.de>
 <ZJh73z2CsgHEJ4iv@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJh73z2CsgHEJ4iv@itl-email>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 01:39:40PM -0400, Demi Marie Obenour wrote:
> On Sun, Jun 25, 2023 at 01:23:40PM +0200, Markus Elfring wrote:
> > > This can be used to avoid race conditions in which a device is destroyed
> > > and recreated with the same major/minor, name, or UUID. …
> > 
> > Please add an imperative change suggestion.
> 
> Will fix in v3.

You don't have to listen to Markus.  Most of us can't see Markus's
emails because he's banned from the vger mailing lists.

Markus, stop bothering people about trivial nonsense.  I've said this
to you before, that if you spot a bug in a patch that's welcome feedback
but if you just have comments about grammar then no one wants that.

regards,
dan carpenter

