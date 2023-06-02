Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054D571FF3F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjFBK0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbjFBKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:25:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15200E50
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:24:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso2510840e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685701468; x=1688293468;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Q536vrpXoLbpW1C6zFSYlWNTwScKe+fs0vNmAKc7wXU=;
        b=jT7/+uAamD3DLHz7oiaOZg0sQP1OAIuAhTDoJLae+Jt4QEkTX7WREA3ZPBcYtnFzHz
         h+o+tpdqA+JYtbSGDmUBqfDCS+zBpdeQvfGShi1mQQMXe2gcZG645CUBr7vgijDWvlcF
         ESyjD0nzAnO8LFCnOw9rudoGR7BOwJzDujFzBmMX/ssOTjFcCRt3k6ZhnW2Uq3Xj4VNi
         r8EL9XD6s7VP2KRfDTlIqNb42UgIaY/NvkearDZuBnIaUEVJIjWt7KFRqHRfhLAr0y1j
         hrK49NsIel0xZjvaHn01rtSQlfyICGZcjdlPncya7DgY8Uhu6B7qnH9pNXcUFEz8m4O0
         lpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701468; x=1688293468;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q536vrpXoLbpW1C6zFSYlWNTwScKe+fs0vNmAKc7wXU=;
        b=l6HuXwBHYVlXq5no7Ad/JRPB/OOTr5XOhMFHOw6w7zj6vPTHARYYaCdfhkc6PTpMtV
         xF8davp/YLZmqy1KbdTk/liL6tnxeenaCDiSW5Jwszu2Uiah9eUQ23rcp1P/4kNwrf8R
         gK7T906yShIeC9UN5EANx8jBrs9IIP1/NR4q8cJpFlqU6We8RfKs6RQCPN6C2pItq5iC
         Oz7vp2PznXHuTFLTjzjE4r6BzDbZ4dCtnfs+wmfkn3Fz6oHfCmNQO2qDzAX7yx4dgFj3
         ThLxKB13fNqv6cj90wJX3oA7g5Sy5Ksn7iGWl+J1fXPEPPX2UzpWG4cWkIvsWhBP+Y++
         yZGQ==
X-Gm-Message-State: AC+VfDwX2Ho1RHMTh0TFgSwfpNz5BX//xZo/0uqgDRoJ9hbgePDUxUdd
        fPIF2gUja2ANTI7C3+SR8B/i8Q==
X-Google-Smtp-Source: ACHHUZ5uOxWjuD+Th59XeUlTguQfW9Gr2KdRw3X8oPchY9B/eGOj8lCOVC6x4lt8OsrILhj5hOOuEQ==
X-Received: by 2002:ac2:51b1:0:b0:4f3:9f9b:ad09 with SMTP id f17-20020ac251b1000000b004f39f9bad09mr1377240lfk.38.1685701468351;
        Fri, 02 Jun 2023 03:24:28 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id g26-20020a7bc4da000000b003f50e88ffc1sm5150674wmk.0.2023.06.02.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:24:27 -0700 (PDT)
References: <875y8geiye.fsf@metaspace.dk>
 <20230531140233.3707302-1-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH v1 4/7] rust: workqueue: define built-in queues
Date:   Fri, 02 Jun 2023 12:23:21 +0200
In-reply-to: <20230531140233.3707302-1-aliceryhl@google.com>
Message-ID: <87a5xi2mcl.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> Andreas Hindborg <nmi@metaspace.dk> writes:
>> Alice Ryhl <aliceryhl@google.com> writes:
>>> +/// Returns the system freezable work queue (`system_freezable_wq`).
>>> +///
>>> +/// It is equivalent to the one returned by [`system`] except that it's freezable.
>> 
>> Can we add a short definition of what "freezable" means?
>
> I don't know what it means, but I would be happy to add an explanation
> if you have one.

From https://docs.kernel.org/core-api/workqueue.html:

"A freezable wq participates in the freeze phase of the system suspend
operations. Work items on the wq are drained and no new work item starts
execution until thawed."

BR Andreas
