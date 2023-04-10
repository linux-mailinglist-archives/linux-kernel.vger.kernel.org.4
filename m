Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465FD6DC705
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDJNEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDJNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:04:37 -0400
X-Greylist: delayed 19716 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 06:04:36 PDT
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE12A359A;
        Mon, 10 Apr 2023 06:04:35 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:7f29:0:640:9a2b:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id E43246001C;
        Mon, 10 Apr 2023 16:04:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8004::1:3b] (unknown [2a02:6b8:b081:8004::1:3b])
        by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id V4Uktq0OceA0-nyYXNgLu;
        Mon, 10 Apr 2023 16:04:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1681131873; bh=Md66GosOjmPPUlltIz4jzWfy7InuFYqLQrcP3JVKSWI=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=Z592sOU4N+WDMoVQCQR/E3vrBzPS5OQpzLhXAFUDGCdcUBmE5OomXRZl0ySgzVCrA
         BLXeUcZwq+CA3BK30llw8pGPvY9LgdDud5A7IOPIrUTh+tX3evuX6L7Pbx6O4a1m+j
         rRz3XhCut/a5CzOt1evW9Ms7CCPW/B2FX+xWqg1w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <0b5cfdc4-817e-30b5-7295-5bca9c31a0b7@yandex-team.ru>
Date:   Mon, 10 Apr 2023 16:04:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: target: cxgbit: check skb dequeue result
Content-Language: en-US
To:     Varun Prakash <varun@chelsio.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20230406150405.300909-1-den-plotnikov@yandex-team.ru>
 <BN9PR12MB532475CDE58B1E570B37DC60BC959@BN9PR12MB5324.namprd12.prod.outlook.com>
From:   Denis Plotnikov <den-plotnikov@yandex-team.ru>
In-Reply-To: <BN9PR12MB532475CDE58B1E570B37DC60BC959@BN9PR12MB5324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.04.2023 14:45, Varun Prakash wrote:
>> On a couple of abort packet paths skb dequeuing may end up with
>> returning NULL, which, in turn, may end up with further null
>> pointer dereference.
>>
>> Fix it by checking the return value of skb dequeuing.
> skbs in csk->skbq are preallocated for critical events in cxgbit_alloc_csk_skb(),
> so there is no need to check for NULL.
Ok, thanks for the reply
