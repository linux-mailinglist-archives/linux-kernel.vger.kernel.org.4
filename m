Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C136E6F7869
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjEDV7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEDV7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:59:37 -0400
Received: from www.vigovproductions.net (www.vigovproductions.net [86.43.91.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4713851
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:59:31 -0700 (PDT)
Received: from vigov-webserver.vigovproductions.net (localhost [127.0.0.1])
        by vigov-webserver.vigovproductions.net (OpenSMTPD) with ESMTP id 73951b20;
        Thu, 4 May 2023 22:59:27 +0100 (IST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=vigovproductions.net; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=mail; bh=
        q34sStAcOgJZ4PRGEgQnL8sNxUc=; b=P8JrFaYv0nF4HA3GtJFa5NsyVSbBogzY
        BBw25EeomLZ6qbftw1G2mzHcouBCRtGfcVrnUFJlmoTEj0T84uZ/JNnql7VAIwYw
        62DHeD8D78MZrJ8VVYSaK4/d1pyZKJ4l7vZMgQKm8CwnyUKkI81/Sa2/41vEJJqi
        rYZR1W94rGZjbJtiCil7m7cYokEwLLSzpQWZvu8uaUdDW3pHhO0RPrqXd1nKjxvn
        kYW4ZGq7maGduIU4x3dXs9wEBu90WjVuW3p1kGj7i02nf9WnoDA6TlI+nRqeJstx
        admnk4eRnS6eeWrP/UeIj/T5dJZfZZXFSvsXehBDQWwcQlol9MUnNQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; d=vigovproductions.net; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; q=dns; s=
        mail; b=dFFnyCqKnnQBIFVxTSii+ReRQ548HpMwT6sEdvYSXAQO8ehhA/ujJmsr
        S9Y2dFVvyNvZulpHCH0fahX7d47nhQGV44IglfuzNF3qxSsRGyyIetUnt1VN2gza
        SC0VLcadaAHSU0mLGKfBQGKrtj2T4EfSwKm8cAFfcFq/6LEmN5dSQFXOvrJ5FYXI
        Zq9H0Lmyl5ONvBSf7sh6BIuEVG7g3a8rWgLyDDtAGDI/ay4RLeFbzS3tZBVfeSE7
        gSrkPYdQ5S518IqAjvySzQKOCkbImLQC6YL5zpnBuIrT3ZCUzNNhZYk5eq4TSrfO
        fMbme0HZEGYjwj+XL0LwR1OdMJoa+g==
Received: from [192.168.1.52] (www.vigovproductions.net [86.43.91.159])
        by www.vigovproductions.net (OpenSMTPD) with ESMTPSA id b5dc9401 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 4 May 2023 22:59:27 +0100 (IST)
Subject: Re: [PATCH] maple_tree: Make maple state reusable after
 mas_empty_area()
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        "support@spotco.us" <support@spotco.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230504175509.2195838-1-Liam.Howlett@oracle.com>
 <560c0037f71be3b0bfe0109ace30cfb869dc7382.camel@intel.com>
From:   Michael Keyes <mgkeyes@vigovproductions.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mgkeyes@vigovproductions.net; prefer-encrypt=mutual; keydata=
 xsBNBFbRwEIBCACtizW7jkoD17g0VZFc+pBoevENZSJ6um8pNY1KEzmUOjHpz3hM+4qYp+/O
 XdmDOuh24n9yegOjy/29ILifLeAmYbzDI/a7+2HHtcOX6ekCWpEaS3tuED+4q0qPPBeN407C
 LVGh4aJqlphQxRcOVduJv1qmxFzuNjLbkL9JVcjQ7iuJgKr3yUp766gULp95z10GmlpogkEV
 2av19L8nHOjMqS+cXZYuqnks+uNEduZNg9U8alVF4Z61DZZO/69XBN3y+fUDZkB7RNIWPkhh
 qbpWwR1wB8El+ZmQveLX64AKp7+y9ouwdlfYxQFFjWcJDnhYlBeFN+3FrFnvWGtrrO6vABEB
 AAHNLE1pY2hhZWwgS2V5ZXMgPG1na2V5ZXNAdmlnb3Zwcm9kdWN0aW9ucy5uZXQ+wsB3BBMB
 CAAhBQJW0cBCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEI0xE/fTb4M8SpoH/RGS
 0SdDeE/FCFY51HNvRs/DfPT+lkpzOmvRz9VghTG1uAJ18XhGZyloj4Y45zvvfwuIZ4h4/Rs5
 hUGZvUNdzqqTsKv1oVzvf7Jk/9Y8ycnfuXHO/QavpKCj5LnRIT0WUFU2tezDs4fwcqw3wXbu
 iz5sa+jTCSNkH6WryytkDx8CSq4KftgjB/uujvz3YMExvS7JjyPSnLsVYXws7HlHvl4u9oMD
 aCfci4bp/0i8oL499yUO7HC5jQwwkP9OZbAlgySPErEpahXG9Kx6MD82yy1JHdLmePyc74M8
 U1k1FKABvjXEigoCRzjVtyiINCpNv6+kMS6M+fQMLuVM5gQKKLjOwE0EVtHAQgEIANgZcP6N
 Zy+jGkG4xp2Cs2E0SndXI4BV4HD6BZhsfQdrluhv058pdkz9Y081v6NzRTFuqeOCNzp1lftS
 qwA6UzpshTQB2SvUk1H/mwdEWhG8DDf4FFtde4m5nEvr0Sj/ZIzaynQIUHzQBnuuS1y4Btyi
 yQGFalRwQqcnuWJ+f+/zj9haXbdWPmZdSxIeO4C3v6+leh/cWdNjFt6xtWy546QkW9IZO++m
 31+DdxlxwlwZQZrrV6orS60HWB4IYJBI0W5/z3EBlqJ026eLiWapYrNtrJyePI9pIP3diOd3
 m6WiFSZELD3YSUHOSvcBoBfkl7LOUALLXKE3/CRucN7sH3MAEQEAAcLAXwQYAQgACQUCVtHA
 QgIbDAAKCRCNMRP302+DPM83CACTbzcLgrHEj5So0+FkSToc3pO5KOH0qLu9fA2TTY3jjM5U
 BproFhlDR3nrZBrtveN7B6ni7efOgZnFlSYfJBLnDg0joQLqM4DrdBJLsGo/eAomMJbLMWSm
 fSQ6VhIISNgPoh7db4HyACfr0SpBmK+OmkMB/yIhtqFjYJ7+Ms1IUd2TMlpDYaP98zsf4Hl5
 A2ClhHpU+EB5AjCA+inVSwtj7NLJC30UOTJV9IbFwhPml/OdwZoSntWGY2OTIuBnt+3XbuHD
 zg9A46AXrTTLkqWrUI6IZtApqJd4sIXytnvf0W8MZ8pmP9wX7isvmychTrQ4JsEFxc3e1Sm9
 m3gn/II+
Message-ID: <8143190d-91a2-70c5-41d0-2926197aea09@vigovproductions.net>
Date:   Thu, 4 May 2023 22:59:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <560c0037f71be3b0bfe0109ace30cfb869dc7382.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.23 20:10, Edgecombe, Rick P wrote:
> On Thu, 2023-05-04 at 13:55 -0400, Liam R. Howlett wrote:
>> Do not update the min and max of the maple state to the slot of the
>> leaf
>> node.  Leaving the min and max to the node entry allows for the maple
>> state to be used in other operations.
>>
>> Users would get unexpected results from other operations on the maple
>> state after calling the affected function.
>>
>> Reported-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
>> Reported-by: Tad <support@spotco.us>
>> Reported-by: Michael Keyes <mgkeyes@vigovproductions.net>
>> Link:
>> https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc84366608624d.camel@intel.com/
>> Link:
>> https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us/
>> Fixes: Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>> Cc: <Stable@vger.kernel.org>
>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> ---
> This fixes it for all the cases I encountered, thanks!
Me too. I had issues running an old version of LuaJIT, and it seems to
be running better than it had in a long time now! Thank you!

-- 
Michael

