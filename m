Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7A714E02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjE2QQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjE2QQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:16:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B38B2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:16:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso6262468a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20221208.gappssmtp.com; s=20221208; t=1685376991; x=1687968991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9Wct7xO9SnRtB839Od+ilnX6yvbSUwAnQvf6TlnDk0=;
        b=EJZ6fuxibG+QARg+qFrUAAdPBCAFkb/bnlhwgGpemrvAFodcSsXifEMu31rMwZ5br/
         YWNNO4d5DSq7RE3COouJAZ5dZrL1Ycfph669wRRoPVse0udSS9zWIi5jr52ggPTCRETr
         1t98QlzjPCmrJjGHwHZGFth+S7kRN60RNSlRT0dmF6P+NCKSAeRJa/FtaCEMFa8CaaNn
         olLBHulWEMRi2uywJDTlEpuw75sv/dG6jufEe280bMPEQ9bwZ8PHThGPMMIrj5qaXWeY
         n5mQK/6746S38hSWd6iO4+PXXTrFchWf1ZRuZ8m+Bp2CWZKAQp2LN8RnDlE4XbKX/CYy
         0rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376991; x=1687968991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9Wct7xO9SnRtB839Od+ilnX6yvbSUwAnQvf6TlnDk0=;
        b=RoH25/r5NRdxYJQxH0HnT+ukikg5QVWzGgTjeMF2gcQBXO5v/MKS2x4zqBq9HgrlB0
         unQsoc/g8zT5OyKmRghnlCIIgOkFwAkRrwOF6g6TRtWHWXWFU7ASgFPX+Au7jI2bg+Dr
         0zUQhVS3pRQ7uUOzWAVs+utFHeSjLvHUO2UVcmYm1tdWutJLGPCTD2YFnZmMGDVoX+6n
         csYDdk2KuV5SORb7hBWVPWX5IpEbiJD3hKPFJrT1r5QEqMuz5NEbI+PfNuOC6SXp+3lx
         7jGGP7xEu406dZUYyU4C7d58Do/oACJfLwu5VuvhwQ3BPLg5RObLH6CvPeb7iyQgIW/C
         rpuw==
X-Gm-Message-State: AC+VfDxIF4elUr9FeuATa57iIdAWoPqHSXrMmIgX+fQemTjYWTxSrGmv
        9bnW3Ov4VuudWLJW5GZIQH/IxQ==
X-Google-Smtp-Source: ACHHUZ5703AgkrC0YfjdiR6RB6L0/mPghnO6w3UOBq6X+IT89WlR+1XQGJJRTPBriE8ntd2yBcVc/A==
X-Received: by 2002:a17:907:d8c:b0:96f:5cb3:df66 with SMTP id go12-20020a1709070d8c00b0096f5cb3df66mr11827105ejc.18.1685376990923;
        Mon, 29 May 2023 09:16:30 -0700 (PDT)
Received: from ?IPV6:2003:d9:972e:ae00:3a2e:69fd:25d5:812f? (p200300d9972eae003a2e69fd25d5812f.dip0.t-ipconnect.de. [2003:d9:972e:ae00:3a2e:69fd:25d5:812f])
        by smtp.googlemail.com with ESMTPSA id f11-20020a1709062c4b00b0096a6bf89259sm5995013ejh.167.2023.05.29.09.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 09:16:30 -0700 (PDT)
Message-ID: <5c4040b2-fdbb-1897-e6a8-1c990226586c@colorfullife.com>
Date:   Mon, 29 May 2023 18:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: LTP: shmget02 fails on compat mode - 64-bit kernel and 32-bit
 userspace
To:     Li Wang <liwang@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, lkft-triage@lists.linaro.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        Martin Doucha <mdoucha@suse.cz>
References: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
 <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
 <b3b0d222-b745-07bc-8dcd-38f762343c84@colorfullife.com>
 <CAEemH2cKjmef+R=gF94J3VT8Kg0inQaWu93dybvPsJM+OM1fQA@mail.gmail.com>
Content-Language: en-US
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <CAEemH2cKjmef+R=gF94J3VT8Kg0inQaWu93dybvPsJM+OM1fQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On 5/20/23 05:58, Li Wang wrote:
> Hi Manfred,
>
> On Sat, May 20, 2023 at 1:55 AM Manfred Spraul 
> <manfred@colorfullife.com> wrote:
>
>     Hi all,
>
>     On 5/19/23 12:57, Arnd Bergmann wrote:
>     > On Fri, May 19, 2023, at 11:17, Naresh Kamboju wrote:
>     >> LTP running on compat mode where the tests run on
>     >> 64-bit kernel and 32-bit userspace are noticed on a list of
>     failures.
>     >>
>     >> What would be the best way to handle this rare combination of
>     failures ?
>     >>
>     >> * arm64: juno-r2-compat, qemu_arm64-compat and qemu_x86_64-compat
>     >>      - shmget02
>     >>
>     >> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>     >>
>     >> tst_hugepage.c:83: TINFO: 0 hugepage(s) reserved
>     >> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
>     >> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
>     >> shmget02.c:95: TPASS: shmget(1644199826, 2048, 1024) : ENOENT (2)
>     >> shmget02.c:95: TPASS: shmget(1627422610, 2048, 1536) : EEXIST (17)
>     >> <4>[   84.678150] __vm_enough_memory: pid: 513, comm: shmget02, not
>     >> enough memory for the allocation
>     >> shmget02.c:95: TPASS: shmget(1644199826, 0, 1536) : EINVAL (22)
>     >> shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536) expected
>     >> EINVAL: ENOMEM (12)
>     > Adding Liam Howlett, Davidlohr Bueso and Manfred Spraul to Cc, they
>     > have worked on the shm code in the past few years.
>     >
>     > This is the line
>     >
>     >       {&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
>     >
>     > from
>     >
>     >
>     https://github.com/linux-test-project/ltp/blob/04e8f2f4fd949/testcases/kernel/syscalls/ipc/shmget/shmget02.c#LL59C1-L59C61
>     >
>     > right?
>     >
>     > I think this is a result of SHMMAX being defined as
>     > #define SHMMAX (ULONG_MAX - (1UL << 24)), so the kernel would
>     > likely use a large 64-bit value here, while the 32-bit user
>     > space uses a much smaller limit.
>     >
>     > The expected return code likely comes from
>     >
>     > static int newseg(struct ipc_namespace *ns, struct ipc_params
>     *params)
>     > {
>     > ...
>     >          if (size < SHMMIN || size > ns->shm_ctlmax)
>     >                  return -EINVAL;
>     >
>     > but if ns->shm_ctlmax is probably set to the 64-bit value here.
>     > It would then trigger the accounting limit in __shmem_file_setup():
>     >
>     >          if (shmem_acct_size(flags, size))
>     >                  return ERR_PTR(-ENOMEM);
>     >
>     > My feeling is that the kernel in this case works as expected,
>     > and I wouldn't see this as a bug. On the other hand, this
>     > can probably be addressed in the kernel by adding a check for
>     > compat tasks like
>     >
>     > --- a/ipc/shm.c
>     > +++ b/ipc/shm.c
>     > @@ -714,7 +714,8 @@ static int newseg(struct ipc_namespace *ns,
>     struct ipc_params *params)
>     >          char name[13];
>     >          vm_flags_t acctflag = 0;
>     >
>     > -       if (size < SHMMIN || size > ns->shm_ctlmax)
>     > +       if (size < SHMMIN || size > ns->shm_ctlmax ||
>     > +          in_compat_syscall() && size > COMPAT_SHMMAX))
>     >                  return -EINVAL;
>     >
>     >          if (numpages << PAGE_SHIFT < size)
>     >
>     I would consider this as ugly: ns->shm_ctlmax can be configured by
>     writing to /proc/sys/kernel/shmmax.
>
>     You can break the test case on 64-bit as well, just by writing
>     SHMMAX+1
>     to /proc/sys/kernel/shmmax
>
>     Thus I think the test case is flawed:
>
>     It is testing the overflow behavior for a configurable value by
>     testing
>     with default+1. But sometimes the actual value is not the default.
>
>     Are the tests running as root?
>
>
> Yes.
>
>
>     What about intentionally setting the value to something useful?
>
>
>
> This suggest sounds reasonable, but I have a question:
> is there any upper limit for setting the /proc/sys/kernel/shmmax?
>
The real limit is 0x7fffffffffffffff. Even if the value of shmmax is 
higher, shmget() fails.

I think this is due to MAX_LFS_FILESIZE in __shmem_file_setup(). I 
didn't attach a debugger, thus I cannot rule out that there is another 
check that also rejects >= 0x800<...>0

The maximum useful size is probably even lower, shmat() would fail since 
the virtual memory size is even smaller.

>
> The test seems to try to test the bounder and as a
> corner case for covering that scenario.
But then just reduce shmmax:

- test that shmget(5000) works

- echo "4999" > /proc/sys/kernel/shmmax

- test that shmget(5000) fails

- echo "5000" > /proc/sys/kernel/shmmax

- test that shmget(5000) works again.



>
>     tmp=$(cat /proc/sys/kernel/shmmax)
>
>     echo "1234" > /proc/sys/kernel/shmmax
>
>     semget() based on {&shmkey1, 1234 + 1, IPC_CREAT | IPC_EXCL, 0, 0,
>     EINVAL},
>     echo $tmp >/proc/sys/kernel/shmmax
>
>     Or, alternatively: read /proc/sys/kernel/shmmax, and skip the test if
>     the value is larger than ULONG_MAX-1.
>
>     --
>             Manfred
>
>
>
>
> -- 
> Regards,
> Li Wang


