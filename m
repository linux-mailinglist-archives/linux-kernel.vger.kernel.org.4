Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A31B732983
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbjFPIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFPIIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:08:50 -0400
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0371F212B;
        Fri, 16 Jun 2023 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; s=LIY0OQ3MUMW6182UNI14; d=nsr.re.kr; t=1686902797; c=relaxed/relaxed; h=content-type:date:from:message-id:mime-version:subject:to; bh=s18rNC9hcygyzIoceGZhyJtVKhz786JZVGmaML1N0+o=; b=dgMiNXcXzZL5u5H+z+64RXu/MZeExHHcOdGKBC/UvwHdS58bbFLx5FZHDTtiV9sREOfjfHkVzFAsf+4maDYLFgQRPqR6BJXYPwWRu+al1GaGRfingeq00VNSqgd1YQl5XISxqpJw+udm3fz091DMm0QXD81YdueOplrPTebz5N52+3so2mn3EewwkeWQKth3XFJHh/6oAdC5zr6aJ7vv0vVFx5b/r/wag1IWC9X8dcP2bxhTsEG0TencUBOx/FfP5CehYAlbACQYWSyieNos1dnWnLp8+t1aDy2f6W6uPp/gaRkPSxPQe1fqlHYdemkSAnR3bXOY55fulJ7OO0NTSg==
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Fri, 16 Jun 2023 17:06:22 +0900
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 855;
          Fri, 16 Jun 2023 17:08:23 +0900 (KST)
From:   Dongsoo Lee <letrhee@nsr.re.kr>
To:     'Eric Biggers' <ebiggers@kernel.org>
Cc:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, letrhee@gmail.com
References: <20230525121301.722682-1-letrhee@nsr.re.kr> <ZHh1H3yKPU68J7Uv@gondor.apana.org.au> <008d01d99518$33db63f0$9b922bd0$@nsr.re.kr> <20230602213946.GD628@quark.localdomain> <005601d99ac9$954f0c70$bfed2550$@nsr.re.kr> <20230610021450.GA872@sol.localdomain>
In-Reply-To: <20230610021450.GA872@sol.localdomain>
Subject: RE: [PATCH v2 0/2] crypto: LEA block cipher implementation
Date:   Fri, 16 Jun 2023 17:08:23 +0900
Message-ID: <003801d9a029$b89228b0$29b67a10$@nsr.re.kr>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGzeUtGMegR59VrglJnt6HijaycHAEgJe7QAN4WbOYB+Jo+6wIyjprpAeW9SuivmOZGgA==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

On Fri, 9 Jun 2023 19:14:50 -0700, Eric Biggers wrote:
>Why are they having "great difficulties" when the kernel already supports
two other "KCMVP-approved block ciphers", ARIA and SEED?  Why aren't they
using dm-crypt with ARIA or SEED?

As you mentioned, the two KCMVP-approved block ciphers, ARIA and SEED, are
supported by the kernel. Therefore, we can use dm-crypt with ARIA or SEED.
However, LEA, being a relatively new algorithm, has distinct advantages over
ARIA and SEED. LEA shows better performance, provides a clearer structure,
and offers simpler implementation on SIMD, compared to ARIA and SEED.
(Furthermore, SEED only provides up to 128-bit security.) Consequently,
there are many products in Korea that use LEA as the default cipher.

Considering these advantages, vendors may add LEA to the kernel of the Linux
distribution by themselves to develop Linux products that supports LEA.
(Some vendors are known to have already attempted this. However, definitely
not all vendors have the capability to do so.) Furthermore, supporting the
most recent and efficient KCMVP-approved block cipher, LEA, may be very
helpful for the vendors to promote their products.

It would cause problems if each vendor implements LEA in the kernel on its
own. It may lead to fragmentation in kernel implementations, potentially
causing compatibility issues among vendors and posing challenges for system
maintenance when faced with major kernel changes.

In addition, the data-at-rest encryption market is just beginning to grow in
South Korea. Therefore, vendors may prefer to use LEA as the default cipher
for data-at-rest encryption, since it is the most recent and efficient one
of the KCMVP approved block ciphers (as mentioned earlier) and they do not
need to worry about the compatibility issues.

Lastly, although LEA-XTS may not outperform AES-XTS or Adiantum, it is still
worthwhile to add LEA to the kernel, as it can be implemented on various
platforms that support SIMD instructions, and it is also an ISO/IEC standard
lightweight cipher.

On Fri, 9 Jun 2023 19:14:50 -0700, Eric Biggers wrote:
>And does LEA (or SEED or ARIA) support in Linux actually solve that
problem?
>Just adding support for these algorithms to Linux does not mean that Linux
automatically becomes a "KCMVP validated cryptographic module", right? Do
you have a complete plan that would actually solve the claimed problem?

As you said, simply adding support for LEA in the kernel doesn't
automatically solve the problem. Of course, additional efforts are needed to
solve it.

As you may know, KCMVP validates cryptographic modules, which means that
when KCMVP validates a Linux-based cryptographic module, it validates the
entire module, not just the Linux kernel inside the module. To obtain
validation for a product, vendors need to develop various tools that can be
used for required testings and write down required documentations.

If LEA becomes available in the Linux kernel, we plan to implement
data-at-rest encryption using LEA on the previously mentioned Gooroom
platform. Vendors can then use it as a reference. We will also develop
backporting codes for several LTS kernels, enabling vendors to utilize LEA
in the Linux distribution that their product runs on. Additionally, we will
implement and provide the necessary tools for KCMVP validation. This series
of efforts, starting with adding LEA to the kernel, will assist vendors in
developing their own KCMVP-validated products, which means the problem can
be solved.

Thank you.

