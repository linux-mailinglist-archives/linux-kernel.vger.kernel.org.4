Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA87331C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244645AbjFPM73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjFPM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:59:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA83581;
        Fri, 16 Jun 2023 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xc0rFww4DDidrWoBZkAi7FUYLAiSH50b8oCJnfR9dZ4=; b=j2z5IAKHx+iYyWyLz2HFE50zJ/
        Jhh4tgKe4YJEQr6oI0WEHTxShrKgtDl8stsJaY/dOoZ9vna81ZCN4XwQplvFkW8/haHb6omkttGT+
        UpOAo65ikQVFI1E7A47AistDWYV+VSIJUM2w8KE3GAzCu0tRCkBbdT0zscpvs6e5krwZNRZCe9RZe
        uTQhd7AkCWHdwfHmX69TV0jzW+xKMUcdOdy4WIDRHcssEkkCVFZz3UGQKXanUtM8VAAAcZB3SgLu5
        FPAxg7yRIIpo4TFPZIHwX+GMBJm0AR/zz7RKHRFhztKcC9TsW/wysILWTFx6leAC4utwq81CNMGZ1
        blemVp9Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qA92m-000crn-1T;
        Fri, 16 Jun 2023 12:59:12 +0000
Message-ID: <c6696073-7882-bdac-32da-c90f181a2804@infradead.org>
Date:   Fri, 16 Jun 2023 05:59:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
Content-Language: en-US
To:     Jordy Zomer <jordyzomer@google.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com>
 <20230615163125.td3aodpfwth5n4mc@desk> <ZIufZn+reW0rza1H@equinox>
 <20230616031447.yslq6ep7lxe6sjv4@desk>
 <CABjM8Zc4WU-QXVDDtfKtGPnsHOhjXYufg+HZ=cdSudXYeKS7YQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABjM8Zc4WU-QXVDDtfKtGPnsHOhjXYufg+HZ=cdSudXYeKS7YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/23 02:39, Jordy Zomer wrote:
> Thanks for the explanation Pawan, a little bit off-topic for this patch but
> shall I send a patch to add this to the documentation of array_index_nospec()
> and fix other calls to that function where the upper bound is not a constant? :)
> 

Yes, please. We don't want to lose that info.

Thanks.

> On Fri, Jun 16, 2023 at 5:15 AM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
>>
>> On Fri, Jun 16, 2023 at 12:31:50AM +0100, Phillip Potter wrote:
>>> I've now looked at this. It is possible for cdi->capacity to be > 1, as
>>> it is set via get_capabilities() -> cdrom_number_of_slots(), if the
>>> device is an individual or cartridge changer.
>>
>> Ohk. Is there an upper limit to cdi->capacity? If not, we are left with
>> barrier_nospec().
>>
>>> Therefore, I think using CDI_MAX_CAPACITY of 1 is not the correct
>>> approach. Jordy's V2 patch is fine therefore, but perhaps using
>>> array_index_nospec() with cdi->capacity is still better than a
>>> do/while loop from a performance perspective, given it would be cached
>>> etc. at that point, so possibly quicker. Thoughts? (I'm no expert on
>>> spectre-v1 I'll admit).
>>
>> array_index_nospec() can only clip the arg correctly if the upper bound
>> is correct. Problem with array_index_nospec(arg, cdi->capacity) is
>> cdi->capacity is not a constant, so it suffers from the same problem as
>> arg i.e. cdi->capacity could also be speculated. Although having to
>> control 2 loads makes the attack difficult, but does not rules out
>> completely.
>>
>> barrier_nospec() makes the CPU wait for all previous loads to retire
>> before executing following instructions speculatively. This causes the
>> conditional branch to resolve correctly. I hope this does not fall into
>> a hotpath.

-- 
~Randy
