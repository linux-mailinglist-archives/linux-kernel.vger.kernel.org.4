Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CBB70875E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjERR4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjERR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:56:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E8C2;
        Thu, 18 May 2023 10:56:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae40dcdc18so17580565ad.2;
        Thu, 18 May 2023 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684432577; x=1687024577;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3G69aZH4uqB82fubrI/45DH+hEMD1HZqbXKUDVHXs4=;
        b=gISJWQhxSOPYp5RVKKjT2X+yM67aAYH+uqz9RitKZIU8HCNyl1HG4N7+RkuF1fRbl4
         2j/G7fJWBGICej8LdDO10xBzC3nf/cdvK2LpqSX/H5qx2+R7joW9MVgyGmQzQY2G7V2j
         56rpoczITKi9u5bRfyzRQDMlQQpuTjXz9TASfJfs2f30P82hZWYzajQCIq/HNLHR/hi0
         kbwgofSmtWrBhN0tQ+FISGJ7gklRIJo0ZlD1EJXmFbXj3CMrR3PE9wCkcvSjBJXjRaRO
         wKRNx7sY3ogXP8Xq1ucmBuowMB4P4rW+uBAKIA3zIVw/fw2E+zaSh9kJAZfUx6AG5e/i
         eWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684432577; x=1687024577;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3G69aZH4uqB82fubrI/45DH+hEMD1HZqbXKUDVHXs4=;
        b=ZPYxk4IuWHCecY4oyH9daU+7pCNYE/Q6HMfgTBxrD+o6YvRZEMJgkBpIEnN2V+CFit
         O9noEKqoTUvzenh/e125OPgvrQLJcPns9Weqswo9uUA1WW67Wu6xfd179//huV0GKais
         XEafZF7h++gPXjSA0ozEuZigQ8S1nnYgS0eDTRRqvYWd09JzFe678EVNWn7lgp6T/4Xv
         d7x+xUDpUIt3t1B3ZvJX/YDzda3YXAhjkK/zgKIv6CLGEcAaNOvS5NS6wMILTwFodFc+
         7lVW8OS2HMCIfthOVkhk+irlt+JGdYBEdgnjCxWv/0UsLj7RPsRQ2D556hhnfhOxDOJd
         AfDQ==
X-Gm-Message-State: AC+VfDwmZHUqvnS5Ztup91ZxcNCnA2JQ+kcboTwX+OAeXbhRCb/E+W1N
        PUi3joS7qcJBwPKMiIUyFP8=
X-Google-Smtp-Source: ACHHUZ6BMWsqPxP8dFTomOtP1RHHtTZ4QK0KBoaEuFsDU4uPtjDNdnBxaLWmTR+Ft40MMAKTuBoFng==
X-Received: by 2002:a17:902:680d:b0:1ad:bb89:16f6 with SMTP id h13-20020a170902680d00b001adbb8916f6mr3079264plk.50.1684432577039;
        Thu, 18 May 2023 10:56:17 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902e31400b001aaea39043dsm1758053plc.41.2023.05.18.10.56.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 10:56:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Problem running perf using Intel-PT with snapshots
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <a8127cb3-7693-22e9-7ace-547f7eb4403b@intel.com>
Date:   Thu, 18 May 2023 10:56:02 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBE205D4-C798-419D-A9B2-42870245B885@gmail.com>
References: <6325A777-706E-462A-8931-59E16D4E37A5@gmail.com>
 <a8127cb3-7693-22e9-7ace-547f7eb4403b@intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 18, 2023, at 12:52 AM, Adrian Hunter <adrian.hunter@intel.com> =
wrote:
>=20
> On 18/05/23 07:26, Nadav Amit wrote:
>> Hello perf masters,
>>=20
>> I am running perf with Intel PT with snapshot mode and the result =
makes no
>> sense. I tried to figure it out myself but failed.
>>=20
>> Excluding the first data file, the rest seem messed up in various =
ways. The
>> only thing that repeatedly shows are calls to __fentry__+0x0. I would =
note
>> that ftrace is not enabled, and I turned off mitigations as I thought =
it
>> might somehow be related, but it did not help.
>>=20
>> Here is an example for execution and output. In between I ran
>> `kill -SIGUSR2 [perf-pid]`. To dump some traces.
>>=20
>> Any ideas what it might be?
>>=20
>> Thanks,
>> Nadav
>>=20
>> --
>>=20
>> $ perf record -e intel_pt/noretcomp=3D1/k --kcore --timestamp -a =
--snapshot=3De262144 --switch-output -m,64
>=20
> --switch-output does not work well with Intel PT.  Intel PT needs all =
of the sideband event information from all files, so decoding errors =
result from splitting files.
>=20
> If you need separate files, consider stopping and restarting 'perf =
record' instead.  If you do that, you may want to look at options like =
-B and -N and --no-bpf-event which can affect how long it takes to stop =
perf record.
>=20
> If you don't need separate files, you can use --time to look at time =
ranges within the resulting perf.data file.

Thank you Adrian. It was driving me crazy and I was sure I am somehow =
not
accounting for some ftrace/rethunk or some other binary rewriting event.

These ideas for workarounds should suffice.

Thanks again,
Nadav=
