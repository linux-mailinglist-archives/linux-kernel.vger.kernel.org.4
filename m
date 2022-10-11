Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7075FBCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJKVM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKVM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:12:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF3A94138
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=/djM76MRiCbUIKCBwzx7wvQO5cksVCd7mpwx6kJlST0=; b=FyMTy9incW2L7Dxwo/cvQPK8FK
        B7hsEkS/HD+pLeQD1HhNF1byvbC6/CK16wLXMQddYOP2igZwUDih3oKqpENTy8gkw8RISDdXL8Zdk
        uFUMaEzIe5rYm8hMM+L6ojqeBuDleOPdGAlUvnQYDsXw6FmApDb8Hdv6dNKwvVj6PAH9G2DVj+s9y
        5qRD1xiCilWu1lyVseFz/QD0zOvl3oCg2S0Z5zkIZCQO53juk4jBQrRQW+t1JurzeJjJM1Xfycl3t
        9wAwkOAegXPTnVnnZ5css1E4ECW1CRxEk/iiGT7p7fr9BQCszTuxnagfajYTSV0m19vcRbZGMxJPE
        v72VitMw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiMY3-005s9f-IH; Tue, 11 Oct 2022 21:12:23 +0000
Message-ID: <d486802c-2431-0818-aef0-c6915d0c35b9@infradead.org>
Date:   Tue, 11 Oct 2022 14:12:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Possibility to disable icotl TIOCSTI
Content-Language: en-US
To:     Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org
References: <Yz8jDbLap91dRVyH@hostpad>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yz8jDbLap91dRVyH@hostpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/22 11:48, Simon Brand wrote:
> Hello,
> 
> in the past there have been attempts to restrict the TIOCSTI ioctl. [0, 1]
> None of them are present in the current kernel.
> Since those tries there have been some security issues (sandbox
> escapes in flatpak (CVE-2019-10063) [2] and snap (CVE 2019-7303) [3],
> runuser [4], su [5]).
> 
> I ask to merge the patches from linux-hardening [6, 7] so users can
> opt out of this behavior. These patches provide the
> `SECURITY_TIOCSTI_RESTRICT` Kconfig (default no) and a
> `tiocsti_restrict` sysctl.

Please send to the hardening mailing list and/or hardening maintainer.

> Escapes can be reproduced easiliy (on archlinux) via a python script:
> ```
> import fcntl
> import termios
> with open("/dev/tty", "w") as fd:
>     for c in "id\n":
>         fcntl.ioctl(fd, termios.TIOCSTI, c)
> ```
> Now run as root:
> # su user
> $ python3 /path/to/script.py ; exit
> uid=0(root) ...
> 
> At least to me, this result was not expected.
> 
> I asked it before on kernelnewbies mailing list. [8]
> Please set me in CC, because I have not subscribed to this list.
> 
> Best and thank you,
> Simon
> 
> [0] https://lkml.kernel.org/lkml/CAG48ez1NBnrsPnHN6D9nbOJP6+Q6zEV9vfx9q7ME4Eti-vRmhQ@mail.gmail.com/T/
> [1] https://lkml.kernel.org/lkml/20170420174100.GA16822@mail.hallyn.com/T/
> [2] https://github.com/flatpak/flatpak/issues/2782
> [3] https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SnapIoctlTIOCSTI
> [4] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=815922
> [5] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=628843
> [6] https://github.com/anthraxx/linux-hardened/commit/d0e49deb1a39dc64e7c7db3340579
> [7] https://github.com/anthraxx/linux-hardened/commit/ea8f20602a993c90125bf08da3989
> [8] https://www.spinics.net/lists/newbies/msg64019.html

-- 
~Randy
