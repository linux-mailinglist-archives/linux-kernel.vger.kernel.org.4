Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9A607C10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJUQUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiJUQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:20:07 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247856BA8;
        Fri, 21 Oct 2022 09:19:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6CC7A418E6;
        Fri, 21 Oct 2022 16:19:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a201 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D1C3B40E67;
        Fri, 21 Oct 2022 16:19:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666369183; a=rsa-sha256;
        cv=none;
        b=z6nCKeO+lcnn3+aKluxACZRN/pPuT45Bb+SOwqOvxogbT0xwsM9ELMkhmFKLY0s0sQkAd8
        XBAemYJvjZdpp5gkALeLixHfco219fSUvyl2cSZpLH7DKQ52dkxSqknC4DG5DxwVNgVrVx
        dZvTmFHqwDCtOundqFfcB+G9bzCxtEOzKQ9at1VcNqLXC12x8nTJNbIgRo6vCsbUomwi6x
        2n9TnLBumrdZ5XSUX79Zr22MbPGyBWouBz8SWqSuEPdBOBZmpyCvXT8JgNrW7c0JS9tn7I
        WkOQRS++ZCMX9Ei3rxu/eD3rRwhty8awRve8N+deMV8jAYT7ns92Lfr3a5P06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666369183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=NW6vJ8DeFyk7asXbesj79NddbzSxSYq+RveUfuG553Q=;
        b=+AJBs71HI0T0gS65Tr2uUDf+M091WTaOoiYSrDJROzGvBGFgPtsXE08azLXNvQsVFjOwaK
        z0YFBTG++HZasFvloHWCnn5L8hVw4iePqYwffNrRwUR+PGyiPifnENjEqb7GLeVwCtSWLH
        64lUlynpvAzJ4p6mkcQTzNWCki4mmikJnZNZpKPXCcxwX0UQMJf5BeuOh6kgYJ7Nci+TdU
        WwE3YGsBhkW6Su9JuZxCFBfvlx8CdH94nHHVbhQDKBijDi4qzIKVdq0YugOc9bQBiNI/ek
        dEeUUAmXWLqrBInFMYA767Neri2TDQY9tPGzEMQTDsqjptX6k8W3KUb0qa5Rhw==
ARC-Authentication-Results: i=1;
        rspamd-6955c7cd5b-khjbw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chief-Wiry: 50cdf9746f680e89_1666369184189_97444717
X-MC-Loop-Signature: 1666369184189:1827427503
X-MC-Ingress-Time: 1666369184189
Received: from pdx1-sub0-mail-a201 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.183.105 (trex/6.7.1);
        Fri, 21 Oct 2022 16:19:44 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a201 (Postfix) with ESMTPSA id 4Mv8nB0rB2z2d;
        Fri, 21 Oct 2022 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666369182;
        bh=NW6vJ8DeFyk7asXbesj79NddbzSxSYq+RveUfuG553Q=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=dX0PmMOhuURcIdOlni51tOvsbJYcE0F2poC8cjMTcF+0caw46mWq3ppZVEbLhNPdy
         6b6NiNtaXMbz6GRXgwFI3GZ/v6Vajkr8F2l4fYg6U3YgmcEfFWWYCrxhNhyVMqYsdA
         snAuQkG89oIRFdAs4vXmNGvLw/R7w/xPshMR7oFNNx2eViaXvKIfymku/FhzNKepJZ
         5RCVWrCw0NBpYq7sgHHQ0qWvReRZnTTSdb+0N6Epb7M0OeMDhdikdj3uRsS0x11Thp
         lHSapcKKj9pOsAfaIS6GGS1AG4ZrM7VP3BtOyEog3au/f2cE4YkkVkxDHKENzKUHjK
         XOlChH0QY5g9Q==
Date:   Fri, 21 Oct 2022 08:58:18 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221021155818.rxp6e3x4lid7eume@offworld>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
 <20221018103619.00004c39@huawei.com>
 <20221018115227.00002a4c@huawei.com>
 <Y1IcpaodrrVrkEcL@iweiny-desk3>
 <20221021095818.00006ed1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221021095818.00006ed1@huawei.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022, Jonathan Cameron wrote:

>> FWIW I did this for the event stuff and did not find it so distasteful...  :-/
>>
>> However the information I am stashing in the cxlds is all interrupt
>> information.  So I think it is different from what I see in the CPMU stuff.
>
>Right now I'm just stashing the max interrupt number to squirt into a callback
>a few lines later. That feels like a hack to get around parsing the structures
>4 times.  If it's an acceptable hack then fair enough.
>
>>
>> > 2. The callback below to find those numbers
>> > 3. Registration of the cpmu devices.
>> >
>> > Reality is that it is cleaner to more or less ignore the infrastructure
>> > proposed in this patch.
>> >
>> > 1. Query how many CPMU devices there are. Whilst there stash the maximim
>> >    cpmu vector number in the cxlds.
>> > 2. Run a stub in this infrastructure that does max(irq, cxlds->irq_num);
>> > 3. Carry on as before.
>> >
>> > Thus destroying the point of this infrastructure for that usecase at least
>> > and leaving an extra bit of state in the cxl_dev_state that is just
>> > to squirt a value into the callback...
>>
>> I'm not sure I follow?  Do you mean this?
>>
>> static int cxl_cpmu_get_max_msgnum(struct cxl_dev_state *cxlds)
>> {
>>	return cxlds->cpmu_max_vector;
>> }
>
>Yup. That state is no relevance to the cxl_dev_state outside of this tiny
>block of code.  Hence I really don't like putting it in there.

Oh absolutely, this is ugly as sin. And if there is anything even worth stashing
the max would only be mbox, as Ira suggested earlier in v1, iirc. So no,
we should not be doing this sort of thing. And if pass one were done in the
callback the need for this would disappear.

>>
>> >
>> > So with that in mind I'm withdrawing the RB above.  This looks to be
>> > an idea that with hindsight doesn't necessarily pan out.
>> > Long hand equivalent with the specific handling needed for each case
>> > is probably going to be neater than walking a table of much more
>> > restricted callbacks.
>>
>> I'm not married to the idea of the array of callbacks but I'm not sure how this
>> solves having to iterate on the CPMU devices twice?
>
>Laid that out in the other branch of the thread but basically either
>1) We stash irrelevant information in cxl_dev_state just to get it into the callback
>   It's not used for anything else and this makes a fiddly and non obvious tie
>   up between different registration steps that appear somewhat independent.

Yeah anything _but_ this.

>
>2) We do the whole double parse twice (so 4 times in total) which is the right
>   option to keep the layering if using this array of callbacks approach, but
>   really ugly.  If we flatten it to straight line code there is no implication
>   of layering and the state being parsed on is right there in a local variable.

If we are keeping this patch, then as mentioned before, I would prefer this. imo
this is better than both 1 above and the open-coding approach.

>I can live with it either way, but it's definitely not as pretty as it looks
>for the mailbox case.

Agreed.

Thanks,
Davidlohr
