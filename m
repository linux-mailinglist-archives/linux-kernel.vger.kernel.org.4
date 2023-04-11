Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC26DDF01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjDKPJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjDKPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:09:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D168F5256
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:08:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gb34so21409138ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681225724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CKtT5Jvf3f0JgKYZh7PXFqhEMkaUpMPr+pEhO6IQ30=;
        b=L4f4rl0cnkxJoP0/ReN7wsAGlmTTMsW0Yid+qhHquTtauzUtz9uoaqBMWJOSc1s6f+
         k9y/UrAki3869xJUZXC2DJHg7qCUcnxDBU6FzuY8k5QzlVSjISZMCnfEt0vIwvoaAj0k
         rUn5E6g57n/D1EcfV7g26SZbv43MRsWsr6MCXOKcet5UXADhqqVQe2SU7ArZWXtd1koQ
         wa76Fs/5DvIne1g0uZ5VJRMPWqusM0iKuIbLJZKC5gxtmbDgn6E7HiuEjQYQ5EU3q6sk
         xN+7HHAJUAEni/wVLSoTduKPHJzfuMF/BfEFHerR0bBZ24LmcT/nEXm9LekkvjZJKSoO
         5vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CKtT5Jvf3f0JgKYZh7PXFqhEMkaUpMPr+pEhO6IQ30=;
        b=HRb74iBlIvL1ibHNB46VfjYhTxDvi2UTZeH9fJN8lELvUWJFhhdvprzVdGw8W/1vRr
         NmwtWmnvP1ZLny83/flSwT1sdaXTSfP06gsreEHzEEollI/fIG4iy76VCRG7QN4O0YnO
         Q+DxzXCfpIhk7EIkYHepLIfX49/Geca830LQLBaWjUo9oOvRMMXmOsYK0LPnYUqAryjm
         GdRrybg7zAdyYmmAB+hBfr5okFKNIZ5rFs/3nFtHm5BP2C3DcEDVCR4bqr7hxi8QkKhK
         SJHoQa2vtQ0Lb+nByKeRT3ze921HykjJ4FLp1UKXZKan1GqfSqR0ECx863qmkVAg8iZt
         B6nA==
X-Gm-Message-State: AAQBX9esDsm14nRRr9t+V02GV3b0c69LO0uENnQIrteWLF1NDTW5ko48
        B0RPD1VocxWY7iC5N9ZYCDMq3Z3B9CeBENyyCBaL8A==
X-Google-Smtp-Source: AKy350arniCGBsMeQ/B/9V1F5ZCcTIUWRYoaxrt/sLV/Wbp04zqFjFkuKph/IMSp06UofYm5hMkq/SUhexA3pnq2IHw=
X-Received: by 2002:a17:907:7f23:b0:94a:8300:7246 with SMTP id
 qf35-20020a1709077f2300b0094a83007246mr3468304ejc.14.1681225723956; Tue, 11
 Apr 2023 08:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com> <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
In-Reply-To: <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 16:08:32 +0100
Message-ID: <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, sdf@google.com,
        error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:18=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> w=
rote:
>
> On Mon, Mar 20, 2023 at 3:48=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > Why would it break?  Is that because the test is buggy, or the kernel i=
s
> > buggy?
>
> This test will be fine, but there have been several times when
> selftests/bpf for stable kernel releases didn't actually compile due
> to backported tests. This is because macros we're redefined, etc.
> Unless those also get picked (seems like a sisyphean task) we'll keep
> seeing broken selftests/bpf on stable.

Hi Greg, Sasha,

Following up on this since it seems to have fallen through the cracks.

Lorenz
