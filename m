Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDFF6B595E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 08:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCKH50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 02:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCKH5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 02:57:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62295121167
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 23:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678521401; i=efault@gmx.de;
        bh=HZ41DeMBS/5NTCASOqzG1Oif6+OpCh8Jix5ZBARGSDw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=c3rvqKVmKMAT+W/HpNZfgDYnRtxNLp5IhijULnsADM04VPhn6ePDxL96mh5Em6g6H
         jXHl/Wx+647XaeJR0n67pbEiUA5riQJnzKCEV0htFgHzJ+CFnnASH3uZzbvVLVgjVU
         fzZksPKVVgOXK0LfbTift8K6gICKeOGTFjsEGNv0+ojNu9UCX0/2bOfcZmi8FSoAzM
         slBB5JvDw3w9MrQM5p16u/eNOUi+FtmSi2kxnOJt4Ta9s2nYMZyW5mnlaLxeOa7rbP
         OXnfp2o+CYjyi/P5ofia2TZTLekopQ1KndihZfTeFslfL9OQHwM3luyhtvFdoPnNKd
         TBG1J4jKhBc7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.251]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1qVjnr1B2s-00x5VS; Sat, 11
 Mar 2023 08:56:41 +0100
Message-ID: <38cca2d87aaebadb502de76be87de9982425042c.camel@gmx.de>
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Date:   Sat, 11 Mar 2023 08:56:37 +0100
In-Reply-To: <58e8015255706fbe83e3a83df8c781bbc734e2a0.camel@gmx.de>
References: <20230306132521.968182689@infradead.org>
         <20230306141502.810909205@infradead.org>
         <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
         <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
         <5b567c5aecabf0a89d92593d99a73bef41bd65da.camel@gmx.de>
         <20230310203814.GA1605437@hirez.programming.kicks-ass.net>
         <58e8015255706fbe83e3a83df8c781bbc734e2a0.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h6VK6LL/jlIZ7zlU+vkfTuBDoEQ4uRHK4jvZS5w5PpdpSDuztZQ
 LpMIeMj++eYscqxgbcbGMfHWEcw/hrmCbqHZqH01sy/3+FrJ43Scwh+iMHZW7ZLEBXL88Aj
 rtIUmOsY7VaO9nUrdDNwkwT4pqsrNQnlc2HXYt8KNuzxpP6uXjJHmGr3FanWXIPcaX1HflQ
 l51dBOEqQrWkCOcgSfG0A==
UI-OutboundReport: notjunk:1;M01:P0:baMf19YiZLY=;zBlIe6TJdTzO4PIlsnpObmHqiSc
 F5A+7AAq9zIAG7B/Ft45H6yFUy2jUP9abOaKx4varOSFueNevgPAQOoQAp5PsKiOfemNRi1q2
 UFBwcqLCGYHfm9aKL1uBc68MBj574NtrhHealzrirfnzUHhtg8AR/00XUN8Ug/hbN7zKhJvGg
 U4EurJM9YE/INhzqVm5XyrYsWLInJ+QODpQ8lLksRhpyz8AR0xL2RU3YuwBJj82VNf4WJ60ly
 C7AZwIkrtRC5ZVTbL0Z3xyeKlWJrvojFjyG4OrM4+Q61NZUfAJY1avcpk07CKOauDJ/iM/cWo
 FFFutnZXTPYeWeTwifGYd4OfVE4pwrlZgG/WX0Gd1Td3jvN0mWPzPqws0mHJ+jdT4/0xTxOiO
 bs8heIGtZeZdA39TRJAHpg5MY9WkAuRvnWJWKgSZz9AZC8t6lJ/TSykIEnz/gDnuAmQtwUwZh
 ISMOk7zX2SsPFxdvQIwVUQs2U0PnwN90VK3oKJ0lIryFf8r2TocTbY9MvMazphhyM5NrtCt3H
 4KK6hSWUJa07wUPFdMbHqhWXp4GveYMq/s2nhcjlGPrFNMPlFR4T1PO/EY6TjzPdl6VwfHFQ4
 C5iLIA4YSSJWC8gZycMFtE7wQCwGhkNgKkFAtU6dfkz0T+LbQE3YQ8j+1tc/KwOscmwdiqnfx
 SdTCDAKrg5vhjIfx2BvP6Wz+D6oE3AholUBdgUtqmEZzcBWz9Nx6CBg/1vMIribAhKhzlTALV
 RR7Iv6bQFn2fnGOIh6PKl6Wfpr4jXtPsq1DqGVId2n/Clnei34tBZjaGXfBjyT4c1n1ZN4X59
 CSa261JRQHH8Fy1X+ivITPEhODVMDG6T45mDGdmhicQpOnVo6g4z2aVMGylOXVWdAxdEAADXl
 dNn4D7i6BweUwZLNTlL3sJclpkAaEab/88dgNhvKsD/mvvHmuIHPin/I8tf1fWMHb2zcfmoIc
 qr7TYw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-03-11 at 06:53 +0100, Mike Galbraith wrote:
>
> massive_intr vs desktop CPU distribution improved as expected, but
> (to me) oddly, the amount of desktop beating up itself did not.

Hmm, maybe expected when fancy deadline math tries to wedge a very wide
GUI into a not so wide and pretty well saturated CPU.

	-Mike
