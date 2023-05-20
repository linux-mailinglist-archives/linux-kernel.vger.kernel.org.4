Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B8070A72D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjETKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:30:27 -0400
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 May 2023 03:30:25 PDT
Received: from ms11p00im-qufo17281901.me.com (ms11p00im-qufo17281901.me.com [17.58.38.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F363189
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1684578146;
        bh=tqfRAHXxqkMRq5yy/mCuKZYNtns1xmh7OZ23Q6NqDgo=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=HqrPzK8Fi31QMrJajZC1pfdDmsXGRvZk1ttutIbB02wE1XdlmtD1FnWD/LQ+rRLkZ
         Q3ca4oG79svJLnEMix4QKUWJGOl8CELYoNUQPATdybp3s/FNDKV6tPbIMOxt+pL4Dk
         q1HK1bvF6zVrXUQu7jxNG3dOyGAqbWGx5dT5p+pStxLAcPJLQo7e0ihhavq3s5Razk
         BTOHy5HHZ7OmiSCcCMKOKgeCW+tyn3C9IkFoJ4iJ2r0v2hQ4Mt3D/j75uR74gFGgSH
         7RrgFaLNGn2mlIQX8dNqTfhoQeMrjEuNTxtqM04JCGbBdkmsi9pZ55jY/8gbfuR9RO
         HpEiySMlcl7iQ==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17281901.me.com (Postfix) with ESMTPSA id 0E0C8D8014C;
        Sat, 20 May 2023 10:22:26 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Fred Lewis <alphagenesis1981@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 20 May 2023 05:22:18 -0500
Subject: Re: [PATCH] binder: fix UAF of alloc->vma in race with munmap()
Message-Id: <6A51954F-79A8-4840-9074-AC4AE8E5D1C3@icloud.com>
Cc:     akpm@linux-foundation.org, arve@android.com, brauner@kernel.org,
        cmllamas@google.com, jannh@google.com, joel@joelfernandes.org,
        kernel-team@android.com, kirill.shutemov@linux.intel.com,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        maco@android.com, mhocko@kernel.org, minchan@kernel.org,
        stable@vger.kernel.org, surenb@google.com, tkjos@android.com,
        tkjos@google.com, vbabka@suse.cz, willy@infradead.org,
        yang.shi@linux.alibaba.com
To:     gregkh@linuxfoundation.org
X-Mailer: iPhone Mail (20E252)
X-Proofpoint-GUID: XEzarbc_irA2XR17RTszTq60ZufsHjSV
X-Proofpoint-ORIG-GUID: XEzarbc_irA2XR17RTszTq60ZufsHjSV
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1011 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=545 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2305200086
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible that someone can help me resolve this issue I have with me ph=
one=20

Sent from my iPhone=
