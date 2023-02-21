Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AAE69E629
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjBURo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjBURoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:44:55 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5C8022798
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:44:52 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31LHiiqC027530;
        Tue, 21 Feb 2023 18:44:44 +0100
Date:   Tue, 21 Feb 2023 18:44:44 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Vincent Dagonneau <v@vda.io>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] tools/nolibc: add tests for the integer limits in
 stdint.h
Message-ID: <Y/UDDIijmryKRIkq@1wt.eu>
References: <20230220202010.37475-1-v@vda.io>
 <20230220202010.37475-5-v@vda.io>
 <3db10837-b632-4df6-9d5f-199fca0eca87@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3db10837-b632-4df6-9d5f-199fca0eca87@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 05:34:01PM +0000, Thomas Weißschuh wrote:
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 882140508d56..ceaf60075331 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -561,7 +561,67 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
> >  		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
> >  		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
> > -		case __LINE__:
> > +		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,   (int8_t)   0x7f); break;
> > +		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,   (int8_t)   0x80); break;
> > +		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,  (uint8_t)  0xff); break;
> > +		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,  (int16_t)  0x7fff); break;
> > +		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,  (int16_t)  0x8000); break;
> > +		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX, (uint16_t) 0xffff); break;
> > +		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,  (int32_t)  0x7fffffff); break;
> > +		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,  (int32_t)  0x80000000); break;
> > +		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX, (uint32_t) 0xffffffff); break;
> > +		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,  (int64_t)  0x7fffffffffffffff); break;
> > +		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,  (int64_t)  0x8000000000000000); break;
> > +		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX, (uint64_t) 0xffffffffffffffff); break;
> > +		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,   (int_least8_t)    0x7f); break;
> > +		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,   (int_least8_t)    0x80); break;
> > +		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX,  (uint_least8_t)   0xff); break;
> > +		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX,  (int_least16_t)   0x7fff); break;
> > +		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN,  (int_least16_t)   0x8000); break;
> > +		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MAX, (uint_least16_t)  0xffff); break;
> > +		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX,  (int_least32_t)   0x7fffffff); break;
> > +		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN,  (int_least32_t)   0x80000000); break;
> > +		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MAX, (uint_least32_t)  0xffffffffU); break;
> > +		CASE_TEST(limit_int_fast8_max);     EXPECT_EQ(1, INT_FAST8_MAX,    (int_fast8_t)     0x7f); break;
> > +		CASE_TEST(limit_int_fast8_min);     EXPECT_EQ(1, INT_FAST8_MIN,    (int_fast8_t)     0x80); break;
> > +		CASE_TEST(limit_uint_fast8_max);    EXPECT_EQ(1, UINT_FAST8_MAX,   (uint_fast8_t)    0xff); break;
> > +#if __SIZEOF_LONG__ == 8
> > +		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
> > +		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
> > +		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
> 
> The _least64 tests should also apply to 32bit, no?
> And moved before the _fast8 tests.

Just thinking loud, it seems to me that all of these _least/_fast ones
can in fact be reliably checked against INT_*, LONG_* and SIZE_MAX. Given
that these ones are already tested, maybe we can just get rid of the ifdef
around all the least/fast and map them to the ones we already test ? That
would possibly remove duplication and make it more readable.

Willy
