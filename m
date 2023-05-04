Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8B6F77C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjEDVFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjEDVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:05:12 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 861BC1154B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:04:50 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ufZypZAvejS6eufZypEZFA; Thu, 04 May 2023 22:29:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683232172;
        bh=eyj6djKYF604oBO3wgJUPGFIgd+fBoKxv5y5jER34kc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WlJ6X16Ia4CVYjwAUtZ1M5KLdoNFs5hZBYffLh63j7JGzYWS6ojY+3J0phTVKLWiB
         sojIX96UtdQ/5Hdfg/7K6Mi4SiEip0HFf9XiiXZx7dvMdsu+CtvFqYY7h/+2USV6JP
         TTvtgrSTTSoN9dskTBSVlLtRayxnXqGhPWRnqLG4C++uKV/+IZSwB5qMubfbiggCDG
         homGyTyxtOv+dpS1t2Xn+UE+jaErN0lJNLJaNkSqTlFHBuSAT/S5msBMWbBdAFO0Sx
         OuGU4M73tOf4ZPmFbk1VpG4WZp2VArTe6MHE41rlqPGmHEFnzgS10npCHnDGBQnuw+
         hqkP25Us1+PJg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 04 May 2023 22:29:32 +0200
X-ME-IP: 86.243.2.178
Message-ID: <490c3544-d22f-1d04-2f10-bcf1f1b3b4d5@wanadoo.fr>
Date:   Thu, 4 May 2023 22:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: RE: [PATCH v2] nvdimm: Use kstrtobool() instead of strtobool()
Content-Language: fr, en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        nvdimm@lists.linux.dev
References: <7565f107952e31fad2bc825b8c533df70c498537.1673686195.git.christophe.jaillet@wanadoo.fr>
 <63d17ed343624_3a36e5294ac@dwillia2-xfh.jf.intel.com.notmuch>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <63d17ed343624_3a36e5294ac@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/01/2023 à 20:11, Dan Williams a écrit :
> Christophe JAILLET wrote:
>> strtobool() is the same as kstrtobool().
>> However, the latter is more used within the kernel.
>>
>> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
>> the other function name.
>>
>> While at it, include the corresponding header file (<linux/kstrtox.h>)
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch was already sent as a part of a serie ([1]) that axed all usages
>> of strtobool().
>> Most of the patches have been merged in -next.
>>
>> I synch'ed with latest -next and re-send the remaining ones as individual
>> patches.
>>
>> Changes in v2:
>>    - synch with latest -next.
> 
> Looks good, applied for v6.3.
> 

Hi,

polite reminder.

If I'm right, only 2 places still use strtobool().
This one and net/bluetooth/hci_debugfs.c.

I'll also try to push the other one and get rid of strtobool().

CJ
