Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF97741ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjF2Dnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:43:46 -0400
Received: from mail-dm3nam02on2072.outbound.protection.outlook.com ([40.107.95.72]:48482
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230447AbjF2Dnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:43:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRX88r6OhKOb7Tj/taetBUtu3ypBBWw8PPLDljqs+ZHnazmQe0kDkS+E+PtXwSmDoYe6lwmGcyrTr4GD6hQMbG2YeoaqIrJdf2gtR+v+qJq0zuZ21ItJ5J4AmKp0MLwQORhMCeYjYFS1czkyBZDs5lLYV+53cZOlv/xdoCEmP3r7zy18PF7EGJUdofRRPgmcSXD0TX0Oqg5sSwg1MYOVmy/n4YVawicxqCxIOc3qx2leGT3xoBom3KdwLom/gSliPP8Fz3Gf8HMRUgyCnO2JJOYb2cOqNe88l9VyqZy3R0F8gs6hjbQu/vpH147i1cg7DgOGwimLedcKgkH5RZaV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0bk9W6HBFXXDYOtsPKWaoobGdv0ngoNdZXZwrsqbgE=;
 b=meA/M85svFHKGHDBi/XgfFniaRWg6sVygMZtLSDAsSwvW3leFqFuoBtnMjNgAA8Hsf2Z/oDPaHCS/Qs1XpDIRs2X2l34hgy2lv1a1CN+2WgxVzRZJC+dsh1oXY2SQegveJv+oCNSS3aztK4ZV02cV6jdYDvxi5OgF3x8l2tYpBNU3ZOn+odrbvbqed+ROrjKlgs2Qgux0Q5JW1GJuF/4reNuReKvCtZ484+XhyPnX78oHoAzE6U4s6rCZZohXEVuVcQd528xyCzJeQ/UpEJZQmgiKwbfRV0Z9erT/HpbWd1tvU7HOxK9bcou16bQOQqLB7dPDCZ4Is62+rE4M5kNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0bk9W6HBFXXDYOtsPKWaoobGdv0ngoNdZXZwrsqbgE=;
 b=SdPnzHzaNiDvRPtAUvMd2mhnrKaN8dvpBhZJMPhzVGt8LoQV6p0VT3F++wwFlM9/23RbW0xGek97RXPpAbfNzNFEPMFIAMuk1Z9sHkSGwRd93nbKY/si/n/lupRH87Qv72WJQFwy9/fKKgeyHEMyqGxoW4QPs44VI8hctPtyke0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SA2PR03MB5801.namprd03.prod.outlook.com (2603:10b6:806:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 03:43:39 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 03:43:38 +0000
Message-ID: <9b732791-87c0-c970-eb68-b02531cc1bdc@synaptics.com>
Date:   Thu, 29 Jun 2023 11:43:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 1/9] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
Content-Language: en-GB
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media@vger.kernel.org, ayaka <ayaka@soulik.info>,
        Brian.Starkey@arm.com, boris.brezillon@collabora.com,
        frkoenig@chromium.org, hans.verkuil@cisco.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, kernel@collabora.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, narmstrong@baylibre.com, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org, tfiga@chromium.org,
        Helen Koike <helen.koike@collabora.com>
References: <20230206043308.28365-1-ayaka@soulik.info>
 <20230206043308.28365-2-ayaka@soulik.info>
 <1e3a583f-f9ef-d2d3-6571-ac3b79d800ce@synaptics.com>
 <6674abe5681c0f4a4e4466e034393359346cfda7.camel@ndufresne.ca>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <6674abe5681c0f4a4e4466e034393359346cfda7.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:510:e::34) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SA2PR03MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: ba15a00f-b5d8-4b84-cca8-08db78530654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlYC7mM9/gd4tctCz850oA+AX0BF6pHyxCZvyk2BzKuaB6vbYtcf8GEAFzWiVvuZAjTFba5PSqiIoZ6wdkg6aU04e6G9Nl/CeeNS6SZQmt7vZ9pjwxTIWEx5ef3/kzKZuC4ykSTB1h0XFNOAiCTzJlLYRl3Yt/48DqQRlPJwh/DBlZ0bBsKuWAg7k1mOPIEWwViZj+f7u1gUivKes5iuEzpXltJo7rVZmW2dRdCws1HSvYwTgutTin4+IOJVGGkjidNYaR3jdsD7tP8+OsiLIDK+g4GC/39hTex70m8os6W3oQBou0NfqgKj40DrvBrjTBN1ferXPTxZxE0CGMQKU+Az0bTE+tVE1vXgFIIcpcMdRoEnBuNVdYD6fQ4FSDBnhWeCn0da7MpbG+mcSToWtUk1PcblALEVnlhU0pS/i5OAKD+EA/nWHKjlUJFUswfJuvNYX0kI7Y/3DslgmtbKJryBH0Q7mScyUGkA20MqwL7jTYKHrRQ0U0F1mxetdg9CPDfl0gynWOFHmsLWGCimgwCxnafhOTm/3PYefehgTBbPGzX/V4sMv1Z9V+qx/DA0J64ByhPrq7TOxl2EIX4+aPNOgP4OCXBTLa832jG+wE+G0E+dLUmqyVLVDLVnPObG5bZNFhYH/Q0+nSGDrnduCOE0bz3WaMic7dzn9B5rXGCKguoW4vZ/vSBdj5BT6Yb+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39850400004)(136003)(396003)(376002)(451199021)(31686004)(186003)(2906002)(66476007)(5660300002)(26005)(6666004)(31696002)(36756003)(7416002)(8676002)(6916009)(52116002)(316002)(54906003)(86362001)(45080400002)(6486002)(478600001)(4326008)(38350700002)(2616005)(38100700002)(66946007)(41300700001)(66556008)(8936002)(83380400001)(6512007)(6506007)(66574015)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGd3Sktkb1FMdXhUS2lscU13TXBXWHMremFoQ2VDdkJrYURlRlRtTWRtb0ZR?=
 =?utf-8?B?MWcyLy9sOHl2NWJxcVV2MTRhVnNFMjBJRDllOVUyWFNoUk8xcWJBdjRiU0lG?=
 =?utf-8?B?MnpzVXdSQmpGUnRqL3RGeGptdGVxWC8yeG1DYXUzNmVMQ2hSbEIvQkdWUVV2?=
 =?utf-8?B?VUZHdmF4MFNPaGZFQUNlNFZQTmpEVGkwejBWdkhwSitOdE11Nm15UGpEM2lN?=
 =?utf-8?B?MnNMNExqa01tSWNHK1JTM2ZmS0haMFhQVnNwTEVVUWFNVjcxTTFZSVVWTldT?=
 =?utf-8?B?a3ZRR2VLU0ZFMitoM1MzZjFxMEJsTkJoSVo5N1VGYllnQkZDMVhjTVQ0SWc4?=
 =?utf-8?B?MThiSFk2d1FEQWRjZDZsU0hyeGRzU1JWMlBwNmpRY3MzY2hLRXdwNUVFbEor?=
 =?utf-8?B?MUVnYlVsdDVEVXNqZ09VZkplZWFPYXFFb29Cakg5cjhCZUZWRTYySmRrSmFJ?=
 =?utf-8?B?VnlpKzN3VkpNRmZSMkNzY0hNL2lZMkJPcEVxUGMxOHQramp0VEltOXFadFFj?=
 =?utf-8?B?MGpkVStrcUtwNDJXRjJpdEMySTI4NEpER3dmaWxYeGxiZUxFZUtRdUlhZzgy?=
 =?utf-8?B?akxCOExYNERCRDJxdGZHQ0JiRnNMZEY3UHBtbnRBOW1UbEprREhUMmRrMGZJ?=
 =?utf-8?B?SjdhMzJ0NVVhMTlUTjREc2dwNG1kZDgzSkkwbDZhSmxQaSt3NHk1YzF6MmU0?=
 =?utf-8?B?cU9MclhNNEtPVU9QVU5temxybVBNS0xURWdLSHdnZEh1TkJ5OERrSndFSjlx?=
 =?utf-8?B?TUZwUktPMkdNaWpmdEtleDgxZlhIaVVRSGZRem02dlN3R0txeEczQTNpNmFs?=
 =?utf-8?B?bkZsRmNOU3lvT1U1WFpXRUpNRjM5R0d1SXlweXNjSWdSRlR4a05nQ1ZrRHpN?=
 =?utf-8?B?a1VGa0xPMXhIT2VvSW8zV0VwdFdOdkFlT0E2SDFCRElPV1RuQlB1S3J0Wktn?=
 =?utf-8?B?c3c3WDhmclUyU05tVklObDhER0QvRXQrMmpsdUpzMjAwdVpSYkFkZHJYOE9I?=
 =?utf-8?B?UFZQWEhEM0xPN21EY1lSRzRSOFVTcEl4QW5iSy90Y3ZPbWo3YXU2dmFBczFJ?=
 =?utf-8?B?YlJPR3JyZjZCWVh4M0pHbVBBUE12WjE2OFhuWXlZcUVVNUZETkErVnVhREtx?=
 =?utf-8?B?SUl5TXdYcU1HTFZ0Tm5pUGtycUx0MjFpQURmTE12ckRxOEc2UkNoTTkvT1Nh?=
 =?utf-8?B?dVc2TW5zcVBYUExFNW1yTmxzT1Rwd2tpd2QzZ0dKNHQxS1dLNXFvRURpa2ZO?=
 =?utf-8?B?QnRJOUZLSVkwV0NMdzRhVFJHaUxEc2wzOU1McmJ0b2ZkVWh6cmJzT3oxKzY3?=
 =?utf-8?B?YUZsT3NKOWRGRFhQZmpTQXViWnVOeVd5ZzFzd0RpRldLdXZZUXVnMlJ1Wlha?=
 =?utf-8?B?Y25ZL0pSdVZBTWhCU0lFTUJKUTh3aTVQQkI1Z0swT0hGVFVVOXBZN3FhVTdy?=
 =?utf-8?B?algwMk8wdkZiU0NpWEhnY2N4ZU9aMlpBTG5wdXFhM1hSSDhjZGc2V0J0UnZJ?=
 =?utf-8?B?YkM0R1BBNTkrREpBUXoySyswbjlzMmFLeXNHVDIzbGJzN281dzg5aGpaSUkr?=
 =?utf-8?B?UTJxUC9kV2xrb1F2OVZRY3FFcWhzRGhpNGRqdnh2a2JrT29NUHhRT2xhbVRl?=
 =?utf-8?B?ZERlMjY3SXVyemxpSy81WU5nYW1KY3UvVDEva1VYK0k2eU5qSUp3cDhKTmhB?=
 =?utf-8?B?eWRoNzJVaHdPM3IwcTdETlc2V2d2aS9BSjE5cWs4RUFsSkxEVlBYRzhSL3BO?=
 =?utf-8?B?VEl5RWt0aXIvVUpyLzdMd29TcmI4TkNtY2FQaDJnbzJ0dE9pSk1nU2dJdEJ0?=
 =?utf-8?B?REJXeTl5T3VadlNWTldvQWZBdXNTaTJJbnlEVlduWjBjd2FCVWtET0hYRVVv?=
 =?utf-8?B?ekYrWXgzVEh3c3dSTXRVY054SERlZ2FYU0ZSVWlLdkhlRU5aOU1ZTy9DRjlv?=
 =?utf-8?B?UDB1UjRNaXhwS2VZYTlJTllNenk4QjdUWFNFR2ZDVFR2ZFZoZjBGVFU2cU1S?=
 =?utf-8?B?clp0OWpqcWp4WTNKTTVxbnNUTkxuVWIrZDVvQS9jMk5iVjdVMmVBS2x1RlZH?=
 =?utf-8?B?ckxDUnc5Vy9WcS9sMEcyN2VyeWtPcTdkTC8rUTBhRHVOdzhxeGlCZVlUVU9u?=
 =?utf-8?Q?kq3OYrUyfLmAiS3rmAvGFlB7i?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba15a00f-b5d8-4b84-cca8-08db78530654
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 03:43:38.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rgxZxQBFSTDb8ZrAEuRlVCwQSUyewCN8dAGI1O5b0tQMOeVxZQjYx40Av09MT5JHQLyLKROTkxi2JLQgxg/4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5801
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/29/23 00:27, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> Hi,
>
> please avoid HTML replies on the mailing list.
  I need to blame outlook.
> Le mardi 27 juin 2023 à 14:42 +0800, Hsia-Jun Li a écrit :
>>> +/**
>>> + * struct v4l2_ext_pix_format - extended multiplanar format definition
>>> + * @type:          enum v4l2_buf_type; type of the data stream
>>> + * @width:         image width in pixels
>>> + * @height:                image height in pixels
>>> + * @pixelformat:   little endian four character code (fourcc)
>>> + * @modifier:              modifier applied to the format (used for tiled formats
>>> + *                 and other kind of HW-specific formats, like compressed
>>> + *                 formats) as defined in drm_fourcc.h
>>> + * @field:         enum v4l2_field; field order (for interlaced video)
>>> + * @colorspace:            enum v4l2_colorspace; supplemental to pixelformat
>>> + * @plane_fmt:             per-plane information
>>> + * @flags:         format flags (V4L2_PIX_FMT_FLAG_*)
>>> + * @ycbcr_enc:             enum v4l2_ycbcr_encoding, Y'CbCr encoding
>>> + * @hsv_enc:               enum v4l2_hsv_encoding, HSV encoding
>>> + * @quantization:  enum v4l2_quantization, colorspace quantization
>>> + * @xfer_func:             enum v4l2_xfer_func, colorspace transfer function
>>> + * @reserved:              drivers and applications must zero this array
>>> + */
>>> +struct v4l2_ext_pix_format {
>>> +   __u32                           type;
>>> +   __u32                           width;
>>> +   __u32                           height;
>>> +   __u32                           pixelformat;
>>> +   __u64                           modifier;
>>> +   __u32                           field;
>>> +   __u32                           colorspace;
>>> +
>>> +   struct v4l2_plane_pix_format    plane_fmt[VIDEO_MAX_PLANES];
>>> +   __u8                            flags;
>>> +    union {
>>> +           __u8                            ycbcr_enc;
>>> +           __u8                            hsv_enc;
>>> +   };
>>> +   __u8                            quantization;
>>> +   __u8                            xfer_func;
>>>
>>>
>>>
>>>
>>>
>>      I heard that a suggestion that we could remove colorimetry fields
>>        here.
>>      Although those are useless for codec M2M drivers if no pixel
>>        formats translation invoked.
>>      Even HDMI(DRM) cares about colorspace.
>>      For example if a downsink(TV) shows RGB formats,  with an YUV
>>        input frame buffer, colorimetry would be important or the wrong
>>        EOTF would be used. If YUV is MPEG range(linear EOTF) while a
>>        non-linear EOFT (full range) is used, you would found the black is
>>        not black enough while the white looks a gray. Also color bias
>>        would happen.
>>      This problem may not happen to a ultra high resolution TV while
>>        only YUV type color formats are supported due to HDMI bandwidth
>>        limitation.
>>      The problem I want to raise is the time cost for enumeration.
>>        Each pixel format with a colorimetry setting would invoke a
>>        ioctl(). For the application likes Gstreamer would enum all the
>>        possible colorimetries.
>>      It would be better we could have something like DRM blob id that
>>        application could copy the data from a non-DMA buffer from the
>>        kernel.
> This is a good topic. Colorimetry could indeed be moved away from the format,
> considering they cannot be enumerated. It remains that this information needs to
> be passed around, and the format of a blob in media space is not has restricted
> as with display HW. I think keeping an "exploded version" of the colorimetry
> remains needed.
>
> Remember though that for stateful decoder, were the information could be stored
> in the bitstream, the decoder is responsible for returning that information.
> Currently its passed through the G_FMT call, it would need to be replaced with a
> control, similar to the HDR10 static metadata. If the colorimetry is no longer
> static in the future, and may change while streaming, one option would be RO
> request. This was foreseen for HDR10+ and Dolby Vision metadata notably, though
> other options exists.

That is why I want to promote importing a whole buffer(framebuffer id) 
from drm.

We can't pass such DMA metadate with the main data(graphics here) in a 
queue.

>
> There exist known decoders that can do YUV to RGB conversion using an inline
> post procesor (VC8000D and newer is an example), and for these to return correct
> colors, the colorimetry information needs to be passed. So its not strictly
> useless.
>
> In short, if we drop colorimetry from format, we also need to go ahead and

I am worrying when people setup up a UVC device(usb camera), they may 
ignore this step.

Camera could be in a BT.601 colorspace than BT.709 which has a slight 
difference. And BT.601 has a full range variant.
> design a replacement for it, that allow for the application to detect changes.
>
> regards,
> Nicolas
>
-- 
Hsia-Jun(Randy) Li

