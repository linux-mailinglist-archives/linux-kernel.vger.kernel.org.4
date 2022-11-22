Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06F8633791
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiKVIyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKVIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:54:38 -0500
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1D24947
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:54:36 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07855445|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.19499-0.000630966-0.804379;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.QE5zelE_1669107271;
Received: from 192.168.220.136(mailfrom:michael@allwinnertech.com fp:SMTPD_---.QE5zelE_1669107271)
          by smtp.aliyun-inc.com;
          Tue, 22 Nov 2022 16:54:34 +0800
Message-ID: <80d747aa-df0e-88e1-7b62-c119bd469153@allwinnertech.com>
Date:   Tue, 22 Nov 2022 16:54:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ALSA: usb-audio: fix urb timeout with URB_ISO_ASAP flag
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, aichao@kylinos.cn,
        wanjiabing@vivo.com, ubizjak@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20221122082040.48591-1-michael@allwinnertech.com>
 <87tu2rv0kj.wl-tiwai@suse.de>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <87tu2rv0kj.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/2022 4:46 PM, Takashi Iwai wrote:
> On Tue, 22 Nov 2022 09:20:40 +0100,
> Michael Wu wrote:
>>
>> When the loglevel is greater than 4, with a long messages printed on the
>> console while playing or recording audios, the usb controller may become
>> abnormal.
>> `usb 1-2: timeout: still 1 active urbs on EP #1`
>>
>> Fix it by configuring the transfer_flags URB_ISO_ASAP flag.
>>
>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> 
> Hrm, that's somewhat backward action to the change we've done years
> ago, commit c75c5ab575af7db707689cdbb5a5c458e9a034bb:
> 
>      ALSA: USB: adjust for changed 3.8 USB API
>      
>      The recent changes in the USB API ("implement new semantics for
>      URB_ISO_ASAP") made the former meaning of the URB_ISO_ASAP flag the
>      default, and changed this flag to mean that URBs can be delayed.
>      This is not the behaviour wanted by any of the audio drivers because
>      it leads to discontinuous playback with very small period sizes.
>      Therefore, our URBs need to be submitted without this flag.
> 
> I rather suspect that your problem is in the USB controller side.
> 
> 
> thanks,
> 
> Takashi
> 
Dear Takashi, thanks for the reminding. Let me check...

-- 
Regards,
Michael Wu
