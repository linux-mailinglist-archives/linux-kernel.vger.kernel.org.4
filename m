Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC162D5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiKQJKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbiKQJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:10:07 -0500
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25065914E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=VUXX+8jrmWkJCXer27nFIgtcX3F8p3BIA/+hpmKo4Dc=;
 b=YwchHuUaYjQ5lXInwdjgN3x/ttsYfOF2d5dVZxVwyIpf0XnPE7wo6Y6Qm3KTeEln4QqLF+hHew51
   KsmEbjPaiazjWyPMQISJw+LAafE7eNMxfgH1BHpgs64hxoGJTvOGevD/bnlVEAt05irLqfOmXSDh
   RCTnyDraQPUKeF9p42UrGPhGvx7dHkrH0HlHR4amDLwsI2YbGnatN8wnEIE2P8+6FZDhrlHQ4kr5
   m/65uTX4bLGepq5tQ+xo/sZMgZXFzn651YpIpFtrM/Rdp6C/k2jZ00U0eKIq1xR+/wnOajUppe/6
   WhZEgrJNS0jblai+0ZFATF8mdne+4DQejp43uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=VUXX+8jrmWkJCXer27nFIgtcX3F8p3BIA/+hpmKo4Dc=;
 b=Ck/by/2yLfp11KPDTLFCAKhq1sDrAkiRXb+haFfTac0H1c14vh/EDdBXp817ljDKxNV8ChgOqgSw
   wunKbKDbXac5gxRFGP9Lq77svAmDQ5k9Mga/3H/6u1B2Rz82cvfWLRlHSO4wySnvuB2FbiW7kZJ2
   vOskU7ryg4xGDOCNq0AhaZTEdTOHj0D69qyAyLkEuHQUf6LOqY3cIwHJLzSbDDpWCfBLnlKywzUa
   sy1Yihahso5QUWCMDqHtWcfNV++LzOUyfDU0OmXeRT31f4QIZqgGyB3NrUaMZh1cVbTqm/HFwtZf
   9U6BkXjEpjdUdDZ6awCt3EH7UWuKdnLra7GfeA==
Received: by omta-ad1-fd2-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20221104 64bit (built Nov  4
 2022))
 with ESMTPS id <0RLH00841ISQ1TB0@omta-ad1-fd2-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Thu, 17 Nov 2022 09:10:02 +0000 (GMT)
Message-id: <8be4e657-53c3-45f5-eec9-c80379cf7ad8@augustwikerfors.se>
Date:   Thu, 17 Nov 2022 10:09:54 +0100
MIME-version: 1.0
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G
 and 512G
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116171727.4083-1-git@augustwikerfors.se>
 <20221116171935.GA24524@lst.de>
 <CGME20221116175159epcas5p4093dd66e85ed287cf9bd9acaec766aa3@epcas5p4.samsung.com>
 <e775398c-97bc-fc1d-a785-6d3c80bce9c6@augustwikerfors.se>
 <20221117071337.GA29422@test-zns>
Content-language: en-US
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20221117071337.GA29422@test-zns>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAH8jGwJkqrsMJZiSWc4NmV1bdxGLCGJRGckZxBi2fZPBWdh/Mn5jedKotFSKG8H
 1EdfzDiHsF0JsQaOuFxoWwPM8TjZ2+Men/70+3zNHOaOsmXGiRBa98q73K6K+j3D
 2hwmMB2q3BbNRWw3UvRyhQAY6f4ha8rWsN98saJmDgLi8T2LseypgAmCyJ3td1iH
 GxyX9M/TxSQMOjL2qPi4LVzjjsrbcOP7AmM153H1ETPkOxVzlnIFxZ0QRX89DgSS
 pwEYjBYLQBVf3shp4YYu8EWf9IzLF92L8kMVmg7TOaOTasWg7DR2dBVfbtfBA/xi
 zKJnAClP4SyZL8t72GPa39XDB5Crci1dNIyrxdQ/wPTY5ZqKWG9VBIunqklyoKgH
 gxjuvG5PRCbGl8St7trDrkfC9ZrbqN0JiV5HDTaCGlveZpZ4fqiysSIYLE5nkf4N hHvGcoY=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-17 08:13, Kanchan Joshi wrote:
> On Wed, Nov 16, 2022 at 06:42:43PM +0100, August Wikerfors wrote:
>> On 2022-11-16 18:19, Christoph Hellwig wrote:
>>> On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
>>>> The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop 
>>>> units
>>>> reports eui as 0001000200030004 when resuming from s2idle, causing the
>>>> device to be removed with this error in dmesg:
>>>>
>>>> nvme nvme0: identifiers changed for nsid 1
>>>
>>> What EUI did it report before? Is the identifier stable after
>>> multiple resume cycles?
>> The original EUI is "002538e621b440e5". Using the patches from [1] and 
>> [2] for debugging I consistently get this output on every resume:
>>> eui changed from 002538e621b440e5 to 0001000200030004
> 
> Can you please share the firmware version of this SSD?

The firmware version is 7L1QHXC7.
