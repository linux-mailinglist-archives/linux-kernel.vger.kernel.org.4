Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732CC73A8A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFVS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjFVS4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:56:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06022A2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:56:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so10274298e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687460209; x=1690052209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckKAMTOi8a3kDMWuuyo3hZiqUz9e4uo6mKty3qDxTuA=;
        b=URaDJWwm464TerYBCqxlHe6wRs4UB+H7UVG5EIMoOCLdUBWnq0k0Ei7ecj4SmZSxzp
         Xz+yjTTpRx/BxnCI9M18amRVFWmMvmP2tZOJ7ObJj6kzE9BOgTwBf//Xr/iCZHLp6I7u
         59LGejfWbpZ0iYF3Y7zdSqnzFUPS05+/tg+WsC3jiIoSTwGIqE6B5GKpFMf4NUbMPFsq
         QAsjKxfsVSqo2UJqdsfV9MB6jtnycAMDMCet+ZC2y2NLKpOvqiucD0BymNzjkUh/1lUG
         CBMskS9LuNp+RsgDfVLUGToalvIjv3bCsOp58o3A7+Opz/YrMi3tgdfEKn5rti02ThYk
         UCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460209; x=1690052209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckKAMTOi8a3kDMWuuyo3hZiqUz9e4uo6mKty3qDxTuA=;
        b=leWY0dimsgJgO3BBiJlX85U3b3GDd/0DBszEPZ5LESiWcyBfv+QVrnq/ku+LMDUOnj
         soEyWUcG4w5Q9yixybKB3u3cVWc6uIuPSM/N3K7X3ZjV0uklTIBYyF24rXGdu+jhDJvo
         KkIUr89JFt8eYz9ZNQ9NDOv1tCVX5rkHv+PBiZNdL15qgKfCec0Iz6RxA5r+0q3QEnv4
         JRn5XXDk7F9OvL4gkmp7ror/gkEXKNqTLB3QMZV36M9qjSQNesAGNpN5jQ7AOBIF6Qiz
         e9KJEIMJa5cPZETv59Oq+5Jw9l10jB8sOJF3LxvWsaIM5pJve3q7+sPF0m6eFXN38egb
         ZczQ==
X-Gm-Message-State: AC+VfDwnHot+Hz6haCCScc2xXuNU9/RzsvYypK9f+kY9SJwI4U4trIE5
        KMrCH41bih6bmDWTlkHfHQUI2A==
X-Google-Smtp-Source: ACHHUZ6bJPaEmkzvn5sghN9XWklP6fLbDqW1O8fXV1hQfMV8434DL9VhoWNoj6MNXTUjXTxz47cgbw==
X-Received: by 2002:a05:6512:3d90:b0:4f8:58ae:8ea8 with SMTP id k16-20020a0565123d9000b004f858ae8ea8mr11841257lfv.58.1687460209142;
        Thu, 22 Jun 2023 11:56:49 -0700 (PDT)
Received: from hera (ppp089210114029.access.hol.gr. [89.210.114.29])
        by smtp.gmail.com with ESMTPSA id c8-20020aa7c748000000b0050bc4eb9846sm4332135eds.1.2023.06.22.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 11:56:48 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:56:46 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 4/4] efivarfs: automatically update super block flag
Message-ID: <ZJSZbmUz583pszny@hera>
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <20230622085112.1521-5-masahisa.kojima@linaro.org>
 <5fe03be6-8c95-0bfa-687d-68e7ddffd97c@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe03be6-8c95-0bfa-687d-68e7ddffd97c@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kojima-san, Jan

On Thu, Jun 22, 2023 at 04:58:50PM +0200, Jan Kiszka wrote:
> On 22.06.23 10:51, Masahisa Kojima wrote:
> > efivar operation is updated when the tee_stmm_efi module is probed.
> > tee_stmm_efi module supports SetVariable runtime service,
> > but user needs to manually remount the efivarfs as RW to enable
> > the write access if the previous efivar operation does not support
> > SerVariable and efivarfs is mounted as read-only.
> >
> > This commit notifies the update of efivar operation to
> > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > operation supports SetVariable.
>
> But it does not re-add it and prevents further requests to the TA (that
> will only cause panics there) when the daemon terminates, does it?

It doesn't, but I think I got a better way out.  Even what you suggest won't
solve the problem entirely.  For the sake of context
- The kernel decides between the RO/RW depending on the SetVariable ptr
- The stmm *module* registers and swaps the RT calls -- and the ptr is now
valid.  Note here that the module probe function will run only if the
supplicant is running
- Once the module is inserted the filesystem will be remounted even without
the supplicant running, which would not trigger an oops, but an hard to
decipher error message from OP-TEE.

So even if we switch the permissions back to RO when the supplicant dies,
someone can still remount it as RW and trigger the same error.

Which got me thinking and staring the TEE subsystem a bit more.  The
supplicant is backed by a /dev file, which naturally has .open() and
.release() callbacks.  Why don't we leave the module perform the initial
setup -- e.g talk to StMM and make sure it's there, setup the necessary
buffers etc and defer the actual swapping of the efivar ops and the
filesystem permissions there?  I might 'feel' a bit weird, but as I
mentioned the module probe function only runs if the supplicant is running
anyway

Cheers
/Ilias

>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
