Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75FF6B1AD6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCIFfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCIFer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:34:47 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E53599;
        Wed,  8 Mar 2023 21:32:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E169542037;
        Thu,  9 Mar 2023 05:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678339974;
        bh=vxS54uTlGMR5PzLTnPcns+95VipCQ+Izczvmh+Eu4cc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=r1C05zelm2ip3ely1YRxB+0WCulNo9AUwrUESJxQv2yj7gW7cyqSVF5NJf0d9LtGP
         zBOVwJVY6yoLBsYWmKSu7CEyZojI9S42pTyme0FnYLoUVXFizgjoHE2PynxMbZsFpS
         Ntl9VZwbrUCyrmruackUcRXRfZh+ZhVsETUxLtKY+rXYUEmUjrgWL9NfoosLLPoYeL
         6ZrufQazfcWRHnkMRbvvwde5y4FCVBWa1rbnbqAMiVpi0TDBSNGCq3blEmhtQ489se
         SYJ9MTtHZLNIiXGQAWvAbGG5mXxhTztPoEdiF+uOUmV7VNA709JYANjos6FWlkOwcU
         meO9fF+DG6/Ng==
Message-ID: <93a57598-9deb-85f2-ebd9-8605404c1ef8@asahilina.net>
Date:   Thu, 9 Mar 2023 14:32:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 01/18] rust: drm: ioctl: Add DRM ioctl abstraction
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mary <mary@mary.zone>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-sgx@vger.kernel.org, Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        linux-media@vger.kernel.org
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-1-917ff5bc80a8@asahilina.net>
 <c047e11f-33d0-6af4-21c3-adb384b68d8b@igalia.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <c047e11f-33d0-6af4-21c3-adb384b68d8b@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 00.32, Maíra Canal wrote:
> On 3/7/23 11:25, Asahi Lina wrote:
>> DRM drivers need to be able to declare which driver-specific ioctls they
>> support. This abstraction adds the required types and a helper macro to
>> generate the ioctl definition inside the DRM driver.
>>
>> Note that this macro is not usable until further bits of the
>> abstraction are in place (but it will not fail to compile on its own, if
>> not called).
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>   drivers/gpu/drm/Kconfig         |   7 ++
>>   rust/bindings/bindings_helper.h |   2 +
>>   rust/kernel/drm/ioctl.rs        | 147 ++++++++++++++++++++++++++++++++++++++++
>>   rust/kernel/drm/mod.rs          |   5 ++
>>   rust/kernel/lib.rs              |   2 +
>>   5 files changed, 163 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index dc0f94f02a82..dab8f0f9aa96 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -27,6 +27,13 @@ menuconfig DRM
>>   	  details.  You should also select and configure AGP
>>   	  (/dev/agpgart) support if it is available for your platform.
>>   
> 
> [...]
> 
>> +
>> +/// Declare the DRM ioctls for a driver.
>> +///
>> +/// Each entry in the list should have the form:
>> +///
>> +/// `(ioctl_number, argument_type, flags, user_callback),`
>> +///
>> +/// `argument_type` is the type name within the `bindings` crate.
>> +/// `user_callback` should have the following prototype:
>> +///
>> +/// ```
>> +/// fn foo(device: &kernel::drm::device::Device<Self>,
>> +///        data: &mut bindings::argument_type,
>> +///        file: &kernel::drm::file::File<Self::File>,
>> +/// )
>> +/// ```
>> +/// where `Self` is the drm::drv::Driver implementation these ioctls are being declared within.
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// kernel::declare_drm_ioctls! {
>> +///     (FOO_GET_PARAM, drm_foo_get_param, ioctl::RENDER_ALLOW, my_get_param_handler),
>> +/// }
>> +/// ```
>> +///
>> +#[macro_export]
>> +macro_rules! declare_drm_ioctls {
>> +    ( $(($cmd:ident, $struct:ident, $flags:expr, $func:expr)),* $(,)? ) => {
>> +        const IOCTLS: &'static [$crate::drm::ioctl::DrmIoctlDescriptor] = {
>> +            const _:() = {
>> +                let i: u32 = $crate::bindings::DRM_COMMAND_BASE;
>> +                // Assert that all the IOCTLs are in the right order and there are no gaps,
>> +                // and that the sizeof of the specified type is correct.
> 
> I believe that not necessarily the IOCTLs need to be in the right order and
> with no gaps. For example, armada_drm.h has a gap in between 0x00 and
> 0x02 and exynos_drm.h also have gaps. Moreover, some drivers, like vgem and
> virtgpu, start their IOCTLs with 0x01.

Yeah, we talked about this a bit... do you have any ideas about how to
design this? I think it should be possible with a const function
initializing an array entry by entry, we just need a two-pass macro
(once to determine the max ioctl number, then again to actually output
the implementation).

I'm not sure why drivers would have gaps in the ioctl numbers though...
my idea was that new drivers shouldn't need that as far as I can tell
(you can't remove APIs after the fact due to UAPI stability guarantees,
so as long as you don't have gaps to begin with...). But I guess if
we're reimplementing existing drivers in Rust we'll need this... though
maybe it makes sense to just say it's not supported and require
reimplementations that have holes to just explicitly add dummy ioctls
that return EINVAL? We could even provide such a dummy generic ioctl
handler on the abstraction side, so drivers just have to add it to the
list, or make the macro take a special token that is used for
placeholder ioctls that don't exist (which then creates the NULL
function pointer that the drm core interprets as invalid)...

Basically I'm not sure if it makes sense to fully support noncontiguous
ioctl numbers automagically, or just say drivers need to explicitly list
gaps. I'd love to hear the opinion of other DRM folks about this!

~~ Lina
