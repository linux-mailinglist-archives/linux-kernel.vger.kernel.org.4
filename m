Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B42601B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJQVLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJQVK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:10:58 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692AF00A;
        Mon, 17 Oct 2022 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z3pkrpoNtemAA6Dij905toPpE7DXlppB3Jc77wbOPXw=; b=GLF4tr2xE+xBE4DRFwh6I99tS0
        qazhqxI1fOWNaJlxdRPy85yCZ6n77R2gHxFhhO3+Dgi9RKgwChx4c74mHH4ACWN++BQQK6v/6mNVQ
        +Yh5WrOAZ6Ln43O6U/svfz2dILNchvTSkZy2Spr3Fz9tyq6awX8jQjSISYFfCgtdNWB35VuvDhty/
        plsCIxWhby4J5Ok8qNF+30cxPmdc6o+3EY1AaPnSqE1KztPdD3ABFgZ02AyhaaoWJcSxHAZoElrEb
        GNXmZX9Nq9vAhsPiQUWl1uuYMbOgF0YFcrfcbE/SV1oPycQBEFQTnuQvhyoSt0QjF0xAW+JccS4db
        0kdk1U/w==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1okXNm-000cOp-Ew; Mon, 17 Oct 2022 23:10:46 +0200
Message-ID: <cb44c124-c940-6f5f-d195-bdf133008ba1@igalia.com>
Date:   Mon, 17 Oct 2022 18:10:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
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
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXHTxc2PM1mz3pm-UEcmch9YG5QKF+JKAUNe9b+1L0OnfA@mail.gmail.com>
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

On 17/10/2022 18:01, Ard Biesheuvel wrote:
> [...]
> 
> In summary, we're better off sticking with the legacy comp interface,
> but unfortunately, due to the way that has been plumbed into the
> scomp/acomp with scatterlists version, that doesn't really help us get
> rid of the memory overhead.
>

Out of curiosity, do you have a number here, like X kilobytes per active
CPU?
