Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093D26C3385
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCUN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjCUN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:58:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF925FDA;
        Tue, 21 Mar 2023 06:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3686B816A9;
        Tue, 21 Mar 2023 13:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAEAC433EF;
        Tue, 21 Mar 2023 13:58:32 +0000 (UTC)
Message-ID: <1a323f49-20e4-46dd-12ac-d991cd257330@xs4all.nl>
Date:   Tue, 21 Mar 2023 14:58:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: meson: vdec: esparser: check parsing state with
 hardware write pointer
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230123094300.2816812-1-christianshewitt@gmail.com>
 <Y8536BzbbghJt0G2@kadam>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <Y8536BzbbghJt0G2@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 23/01/2023 13:04, Dan Carpenter wrote:
> On Mon, Jan 23, 2023 at 09:43:00AM +0000, Christian Hewitt wrote:
>> From: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Also check the hardware write pointer to check if ES Parser has stalled.
>>
> 
> Presumably this is something which has happens in real life?  Say a user
> has this hardware and is wondering if this patch fixes their bug, what
> does this bug look like to them?
> 
> Please add a Fixes tag.

I'm marking this as Changes Requested in patchwork.

Dan has good comments, and in general, if something is 'weird', then
it needs to be commented carefully.

Regards,

	Hans

> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>  drivers/staging/media/meson/vdec/esparser.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
>> index df5956c6141d..41b705f999b2 100644
>> --- a/drivers/staging/media/meson/vdec/esparser.c
>> +++ b/drivers/staging/media/meson/vdec/esparser.c
>> @@ -300,6 +300,7 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>>  	u32 num_dst_bufs = 0;
>>  	u32 offset;
>>  	u32 pad_size;
>> +	u32 wp, wp2;
>>  
>>  	/*
>>  	 * When max ref frame is held by VP9, this should be -= 3 to prevent a
>> @@ -354,15 +355,21 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>>  	}
>>  
>>  	pad_size = esparser_pad_start_code(core, vb, payload_size);
>> +	wp = amvdec_read_parser(core, PARSER_VIDEO_WP);
>>  	ret = esparser_write_data(core, phy, payload_size + pad_size);
>> +	wp2 = amvdec_read_parser(core, PARSER_VIDEO_WP);
>>  
> 
> Why is check not done inside the esparser_write_data() function?  It
> really feels like doing a write where nothing happens should be a bug
> for both callers...
> 
> The esparser_write_data() function returns > 0 on success, 0 on timeout
> (I guess timeout is an error-ish) and negative if the user presses
> CTR-C.  There are no comments to explain the unusual returns.  Could we
> clean this up so it just returns negatives on error and zero on success
> or if not then let's add a comment explaining what's going on?
> 
>>  	if (ret <= 0) {
>> -		dev_warn(core->dev, "esparser: input parsing error\n");
>> -		amvdec_remove_ts(sess, vb->timestamp);
>> -		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>>  		amvdec_write_parser(core, PARSER_FETCH_CMD, 0);
>>  
>> -		return 0;
>> +		if (ret < 0 || wp2 == wp) {
> 
> So in this patch if there is a timeout but something was written then
> that's kind of a success path?
> 
> regards,
> dan carpenter
> 
>> +			dev_err(core->dev, "esparser: input parsing error ret %d (%x <=> %x)\n",
>> +				ret, wp, wp2);
>> +			amvdec_remove_ts(sess, vb->timestamp);
>> +			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>> +
>> +			return 0;
>> +		}
>>  	}
>>  
>>  	atomic_inc(&sess->esparser_queued_bufs);
> 

