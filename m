Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BBB601B39
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJQVZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJQVZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:25:29 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC95E7C1DB;
        Mon, 17 Oct 2022 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SK2IIiJtqurXP7/5Xu549vObhZku8RTsovOn/ZfaVWE=; b=R08nc1umIGS0960uO2p317g4WR
        WPhkVeDEP4DEx3+6Vgl1y8PZxF41bmD+OBUM9imOdzhnKpiYGuD9DUBu2RU7iUz9XD0DXYfpWs1Pu
        UdeejJKQWC4F774Eyxzg02q87LDsgApCLM/fzCxBdDFphGojMjf3xy6L8qNeOeyDIM13noVWEwS6k
        E+l3W3Xo8JNZvitXgZnGjlcQE0RxEIy/ZNGatbZN3qbQByUqXnXZpgbnj77cp1rKjZkkro0/jY6m9
        MbspOETuqDIKANEz1nebJzASPvmDYQ77tPGYS4HMNIWgk7mRTj8Dbb0aQcku5dqKz+w9crbggaRR7
        WIvzropw==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1okXbp-000cjZ-6i; Mon, 17 Oct 2022 23:25:17 +0200
Message-ID: <dbcc136d-7993-884e-f1de-ac696ae4bd0f@igalia.com>
Date:   Mon, 17 Oct 2022 18:25:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
 <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook>
 <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
 <202210171237.DF5D4A3FD7@keescook>
 <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
 <202210171307.32A5D9C07@keescook>
 <CAMj1kXHced1khwsrHqMUmECh_7irYOckFd+Sx3z9KSmsL7tPxw@mail.gmail.com>
 <202210171333.309A3D9@keescook>
 <CAMj1kXHTxc2PM1mz3pm-UEcmch9YG5QKF+JKAUNe9b+1L0OnfA@mail.gmail.com>
 <cb44c124-c940-6f5f-d195-bdf133008ba1@igalia.com>
 <CAMj1kXGA=kBdahDTuFDPzZKf5bbvxH2Ns7Ows+5D-PAx8rwP2w@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXGA=kBdahDTuFDPzZKf5bbvxH2Ns7Ows+5D-PAx8rwP2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 18:16, Ard Biesheuvel wrote:
> On Mon, 17 Oct 2022 at 23:10, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>> [...]
>> Out of curiosity, do you have a number here, like X kilobytes per active
>> CPU?
> 
> 2x128 KB per CPU, which makes 128  KB also the maximum input/output
> size per request when using this interface. (SCOMP_SCRATCH_SIZE)
> 
> On my 32x4 CPU workstation, this amounts to 32 MB permanently locked
> up for nothing when the pstore driver is loaded (with compression
> enabled)

Thanks! This is really something...

