Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EAE7380E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjFUJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjFUJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:51:25 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375821728;
        Wed, 21 Jun 2023 02:50:34 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-31114d47414so1270311f8f.1;
        Wed, 21 Jun 2023 02:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341033; x=1689933033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foLI8oofbou4hrt7TVAkrvJDeJCFo178hS/ZQokH0vY=;
        b=lWFu5BQrlbd+itODc5zHIy53obAPEc0y+6ptIVyD8qQhCiYiBFD+NLnd8+RFUhlDPQ
         iBaQg3NX8ohqweNX8ci2ZOgyV9jQhqGybnx4zMXYMbrB7kA2uNFRJtovffVomi58lHiY
         CK6YTmnaBPOcyIfcrmFxPqSSOqbSydozkhD9l1bohaejzmbe/mmvLTeuLFkw0sx6Sj/Z
         1uoPXGhRJAFU9MrJkrwLC9vdj0VPB9pFhfZ8U8cdpeQvv6kHQ7cbeXM7iNflhYk/3U+X
         Tq0OsDiJEUQI7HGbWDsJY4C9K0wU9wsZpfHS9de6CX0vSJicdbSd6Q5LUUmefPctT8SW
         ecMA==
X-Gm-Message-State: AC+VfDwIrSPhd0Y4xTAjD2kuwCrTzI9D+VP8Fe7sdwCFCv7BVUbyqbZW
        UgA49meeNGf6rjY98yWRgSLD/+sScDw=
X-Google-Smtp-Source: ACHHUZ4Hah7qAiMDMVHWF7ildurOLQasEXFh5ekDJrboVLcvEPHKdYejnUi/v+YlmoRmMei1jMIPWw==
X-Received: by 2002:adf:f312:0:b0:30e:460b:bede with SMTP id i18-20020adff312000000b0030e460bbedemr12934277wro.5.1687341032561;
        Wed, 21 Jun 2023 02:50:32 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4fc9000000b0031134bcdacdsm3998202wrw.42.2023.06.21.02.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 02:50:31 -0700 (PDT)
Message-ID: <083e29ff-4ad0-d05f-0521-56ace13629e6@grimberg.me>
Date:   Wed, 21 Jun 2023 12:50:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
 <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
 <f6rvvhgim4nk34onfgbwyfctgvgdbdigwbsugjvizgtli46p57@s7c4gkqrpjqy>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f6rvvhgim4nk34onfgbwyfctgvgdbdigwbsugjvizgtli46p57@s7c4gkqrpjqy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +nvmf_wait_for_queue_count() {
>>> +	local subsys_name="$1"
>>> +	local queue_count="$2"
>>> +	local nvmedev
>>> +
>>> +	nvmedev=$(_find_nvme_dev "${subsys_name}")
>>> +
>>> +	queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
>>> +
>>> +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
>>> +
>>> +	queue_count=$((queue_count + 1))
>>> +	if grep -q "${queue_count}" "${queue_count_file}"; then
>>> +		return 0
>>> +	fi
>>> +
>>> +	echo "expected queue count ${queue_count} not set"
>>> +	return 1
>>> +}
>>> +
>>>    set_nvmet_attr_qid_max() {
>>>    	local nvmet_subsystem="$1"
>>>    	local qid_max="$2"
>>> @@ -56,10 +76,7 @@ set_qid_max() {
>>>    	local qid_max="$3"
>>>    	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
>>> -
>>> -	# Setting qid_max forces a disconnect and the reconntect attempt starts
>>> -	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
>>> -	nvmf_wait_for_state "${subsys_name}" "live" || return 1
>>> +	nvmf_wait_for_queue_count "${subsys_name}" "${qid_max}" || return 1
>>
>> Why not simply wait for live? The connecting is obviously racy...
> 
> That is what the new version is doing. It's waiting for the live state and then
> checks the queue count.

Maybe don't fold waiting for live into waiting for queue_count.
