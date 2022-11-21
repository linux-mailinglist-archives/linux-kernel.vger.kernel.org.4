Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E1632F97
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKUWLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKUWLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:11:16 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D39C80D7;
        Mon, 21 Nov 2022 14:11:15 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E1E3D102005;
        Mon, 21 Nov 2022 22:11:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a277.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 33B081008B4;
        Mon, 21 Nov 2022 22:11:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669068674; a=rsa-sha256;
        cv=none;
        b=AlHIGaKJjWcqSfqv9muvgxoNCZOYzEtSyKUifOga7oDFICG09vCqy1SAuEPWkZJrwMd+TP
        k58SbDfzl/4AUA/77/PNZcq5RiiICIH6YjMiIuq/n7TxN4eoc6OoOkpy0seL773/CmqXYD
        ZARGZ9pr6Wxx1g4nNzZjup88uEhkammLX774Yt2kXzOXTj2RoS6Gb3oQV9HckUgWewQ47X
        2Cb3FFiSK4jkAkx08Ve2+8eEOij8fKBmGD7PuDuBZvWl2nSQ5wdYH6AohZClXvgeD4qxql
        UEm4hS5wBinnbqadEebAGuHVIFbqTUoD8/gb0TucUYDpT5sOblrU+g0ddHZGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669068674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=dXY4YIB/wDJAi95L74t01ijuWPqACaPO27Z8NICnvuQ=;
        b=CyYqsrqJE1jlGMpH3sDP05KGMlW0WkoRiNplqBDJIz8R7goFW4LJv/HhyvqVfqd0Ffms6v
        XM11eeIyy7I3E1ysz0jwGwwW6bDH4f6Dui2q4YeTpFsVHbVp82V42GKIr4zYYSJD6m/4jM
        Z/aPS0rGR7mnNDZloiza3hLP2LT/cGMkXT7nVkvTN1PYWfK5B7/tDvjphuneiot+ot/JNT
        7vHFjacrWmE0cP1gDdHonCOEAoEHsqUiw8+cMzQ6ckxq3Qit7mdhdfbBg1EFbgwKUq/bAS
        0XB8Ugrh0P66CQxnEWIfTrY7nsvg0NPFE2m9/vfOB2gd5PFvZ6qJRNJ12pDckA==
ARC-Authentication-Results: i=1;
        rspamd-65567d767-pkj8f;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Eight: 43b35e344d9cb504_1669068674589_3648091160
X-MC-Loop-Signature: 1669068674589:809164092
X-MC-Ingress-Time: 1669068674589
Received: from pdx1-sub0-mail-a277.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.54 (trex/6.7.1);
        Mon, 21 Nov 2022 22:11:14 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a277.dreamhost.com (Postfix) with ESMTPSA id 4NGM6T26xNz2D;
        Mon, 21 Nov 2022 14:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1669068674;
        bh=dXY4YIB/wDJAi95L74t01ijuWPqACaPO27Z8NICnvuQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=WZEV3VZ7xYJV1dlg6OtwWXBxE6wkd8a+pRlD+mEotkbi5DdeR+esp0zKahmIE/z/5
         Ta2KbTYbdCzC4LTIUt+NCQhW5T+Zmtj4s1hUjQ0QzVGDvr3THATIKQGoFyqf7zDQ+u
         v6vQl3f6QUD3CbFN+dwXwAAdwz1snTz16aV9WjR5D8WaW++/cRsk3tBwgKlHEUswxo
         tTSVcor3iorLcq8Q54bbtZYPaX6UmEks89X0EkBFANuP2AgLEJBCyiFVFaz9erdw99
         H1WCF2SgPvTeWbKM7XYEbvVFRt558cbAaj+dWbkncpod7A1aUjP/T05oAklvDmpta7
         NKT6cJWJKiXSg==
Date:   Mon, 21 Nov 2022 13:48:04 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/mbox: Add background operation handling machinery
Message-ID: <20221121214804.zy6i5basztlim66t@offworld>
References: <20220804045029.2905056-1-dave@stgolabs.net>
 <20220804045029.2905056-2-dave@stgolabs.net>
 <20220825134152.00005244@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220825134152.00005244@huawei.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022, Jonathan Cameron wrote:

>> +/*
>> + * Ensure that ->mbox_send() can run safely when a background
>> + * command is running. If so, returns zero, otherwise -EBUSY.
>
>As above, I'm not sure this is necessary given you should get
>a sensible error code in response to any such message.
>E.g. media disabled.

So this is necessary to prevent mischief in the polling case
where you can have windows where the driver is out of sync
with the hardware - hw finishes async command but driver
(sleeping poller) has not acknowledged this. In the irq case,
yeah this would be redundant and not needed.

Thanks,
Davidlohr
