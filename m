Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C707298DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbjFIL6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbjFIL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:58:27 -0400
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4F81A2;
        Fri,  9 Jun 2023 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; s=LIY0OQ3MUMW6182UNI14; d=nsr.re.kr; t=1686311754; c=relaxed/relaxed; h=content-type:date:from:message-id:mime-version:subject:to; bh=PJJPGMVZjnUWjveVCX/w75NBSJD4bx3rT7ZTYxo5o7M=; b=WFYdDbFSAM8Z2LWYg7cabPi5a/DNSrl8p4YvcEbWOMOmTuuTrYBT0Ew9kNZpQkhgtWtIBYkMm0S9DwD0KNZepAddAMv3HIhxo753GrIbBcMeGiurvyEtoedF4Jl3ivTbWAvQ7n7esoZoJLnzeQtbMwANVxnb0uRkltwKxFvtIfngYoibkIci2163PfO9mZMPegG8xrW3f9qSt1W2qZwgv1WCTpkaozBA9d4m3FIzcGYXK14F/X9mT8mZYWRP0FftKvVpp84t3MyxuP6nuRa+rUu4VAqU5S0oBidAv0lRnVcL6vpHDyhPGXQDTzH1k7/+N26ypExQuwLY1/nc5APU0w==
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Fri, 09 Jun 2023 20:55:39 +0900
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 80;
          Fri, 9 Jun 2023 20:57:36 +0900 (KST)
From:   Dongsoo Lee <letrhee@nsr.re.kr>
To:     'Eric Biggers' <ebiggers@kernel.org>
Cc:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, letrhee@gmail.com
References: <20230525121301.722682-1-letrhee@nsr.re.kr> <ZHh1H3yKPU68J7Uv@gondor.apana.org.au> <008d01d99518$33db63f0$9b922bd0$@nsr.re.kr> <20230602213946.GD628@quark.localdomain>
In-Reply-To: <20230602213946.GD628@quark.localdomain>
Subject: RE: [PATCH v2 0/2] crypto: LEA block cipher implementation
Date:   Fri, 9 Jun 2023 20:57:36 +0900
Message-ID: <005601d99ac9$954f0c70$bfed2550$@nsr.re.kr>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGzeUtGMegR59VrglJnt6HijaycHAEgJe7QAN4WbOYB+Jo+66+u6H7A
Content-Language: ko
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Jun 2023 14:39:46 -0700, Eric Biggers wrote:
> I haven't seen any patch that proposes adding LEA support to fscrypt.
> Also, I'm
> not sure that the information you've provided so far is sufficient
> motivation
> for adding it to fscrypt.  I did recently allow another national pride
> cipher,
> SM4, to be added to fscrypt, but that was only because a user said they
> were
> being *required* to use SM4.  It's not clear that's the case for LEA.

Hello,

We thought that having the dm-crypt module as an in-kernel user of this
patch is enough to apply it. Of course, it would have been better to include
fscrypt in the patch, as file system encryption is very important for
data-at-rest encryption along with disk encryption.

Unfortunately, currently, vendors trying to supply Linux-based data-at-rest
encryption products by utilizing the dm-crypt or the fscrypt modules to
government agencies or public institutions in Korea are experiencing great
difficulties.

According to Korean regulations, the data transmitted and stored by
government agencies and public institutions must be protected using KCMVP
validated cryptographic modules. (KCMVP, the Korean Cryptographic Module
Validation Program, is a Korean security accreditation program for
cryptographic modules, like the CMVP in the United States.) According to the
KCMVP, cryptographic modules that are to be adopted in government agencies
and public institutions are required to use the approved cryptographic
algorithms to encrypt data. As mentioned earlier, LEA, SEED, and ARIA are
the only KCMVP-approved block ciphers.

As you know, the best approach to performing data-at-rest encryption on
Linux is using kernel modules like dm-crypt or fscrypt. Therefore, applying
the proposed patch would be very beneficial for the vendors wanting to
supply Linux products to government agencies or public institutions in
Korea, since they must use the KCMVP-approved cryptographic algorithms such
as LEA.

We kindly request a positive response to enable the utilization of
data-at-rest encryption in such special circumstances, thereby improving
Korea's Linux environment.

Thank you.

